const express = require('express');
const exphbs = require('express-handlebars');
const db = require('./db-connector');
const path = require('path');

const app = express();
const PORT = 4401; 

// Handlebars setup
app.engine('hbs', exphbs.engine({
  extname: 'hbs',
  defaultLayout: false,
  partialsDir: path.join(__dirname, '../frontend/views/partials') 
}));

app.set('view engine', 'hbs');
app.set('views', path.join(__dirname, '../frontend/views')); 

// Body parser for form data
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Static assets (style.css at some point)
app.use(express.static(path.join(__dirname, '../frontend')));

// Routes
app.get('/', (req, res) => {
  res.render('index'); 
});

// reset route
app.post('/index/reset', async (req, res) => {
  try {
    await db.query('CALL sp_load_computerStoreDB()')
    res.render('index'); 
  } catch (err) {
    console.error('Error resetting database:', err);
    res.status(500).send('Error resetting database');
  }
});

// orderItems route
app.get('/orderitems', async (req, res) => {
  try {
    const [orderitems] = await db.query(`
      SELECT oi.orderItemID, oi.quantity,
            o.orderID, DATE_FORMAT(o.orderDate, '%m/%d/%Y') AS orderDate,
            p.productID, p.model, p.price
    FROM OrderItems oi
    JOIN Orders o ON oi.Orders_orderID = o.orderID
    JOIN Products p ON oi.Products_productID = p.productID;
    `);

    const [orders] = await db.query(`SELECT orderID, DATE_FORMAT(orderDate, '%m/%d/%Y') AS orderDate FROM Orders`);
    const [products] = await db.query(`SELECT productID, model FROM Products`);

    res.render('orderitems', {
      orderitems,
      orders,
      products
    });
  } catch (err) {
    console.error('Error loading orderitems:', err);
    res.status(500).send('Error loading orderitems');
  }
});

app.get('/products', async (req, res) => {
    try {
    const [products] = await db.query(
      `SELECT productID, manufacturer, model, productType, color, price FROM Products`
    );

    res.render('products', {
      products: products
    });
  } catch (err) {
    console.error('Error loading products:', err);
    res.status(500).send('Error loading products');
  }
});

app.get('/orders', async (req, res) => {
  try {
    const [customers] = await db.query(
      `SELECT customerID, email FROM Customers`
    );

    const [orders] = await db.query(
      `SELECT o.orderID, DATE_FORMAT(o.orderDate, '%m/%d/%Y') AS orderDate,
              o.shippingAddress, o.orderTotal,
              c.customerID, c.email
      FROM Orders o
      JOIN Customers c ON o.Customers_customerID = c.customerID`
    );

    res.render('orders', {
      orders: orders,
      customers: customers
    });
  } catch (err) {
    console.error('Error loading orders:', err);
    res.status(500).send('Error loading orders');
  }
});

app.get('/customers', async (req, res) => {
  try {
    const [customers] = await db.query(
      `SELECT customerID, email, streetAddress, phoneNumber FROM Customers`
    );

    res.render('customers', {
      customers: customers
    });
  } catch (err) {
    console.error('Error loading customers:', err);
    res.status(500).send('Error loading customers');
  }
});

app.post('/customers/add', async (req, res) => {
  const { email, streetAddress, phoneNumber } = req.body;

  const query = `
    INSERT INTO Customers (email, streetAddress, phoneNumber)
    VALUES (?, ?, ?);
  `;

  try {
    await db.query(query, [email, streetAddress, phoneNumber]);
    res.redirect('/customers');
  } catch (err) {
    console.error('Error adding customer:', err);
    res.status(500).send('Error adding customer');
  }
});

app.post('/customers/update', async (req, res) => {
  const { customerID, email, phoneNumber } = req.body;

  const query = `
    UPDATE Customers
    SET email = ?, phoneNumber = ?
    WHERE customerID = ?;
  `;

  try {
    await db.query(query, [email, phoneNumber, customerID]);
    res.redirect('/customers');
  } catch (err) {
    console.error('Error updating customer:', err);
    res.status(500).send('Database update error');
  }
});

app.post('/customers/delete', async (req, res) => {
  const { customerID } = req.body;

  const query = `
    DELETE FROM Customers
    WHERE customerID = ?;
  `;

  try {
    await db.query(query, [customerID]);
    res.redirect('/customers');
  } catch (err) {
    console.error('Error deleting customer:', err);
    res.status(500).send('Database delete error');
  }
});

app.post('/products/add', async (req, res) => {
  const { manufacturer, model, productType, color, price } = req.body;

  const query = `
    INSERT INTO Products (manufacturer, model, productType, color, price)
    VALUES (?, ?, ?, ?, ?);
  `;

  try {
    await db.query(query, [manufacturer, model, productType, color, price]);
    res.redirect('/products');
  } catch (err) {
    console.error('Error adding product:', err);
    res.status(500).send('Error adding product');
  }
});

app.post('/products/update', async (req, res) => {
  const { productID, price } = req.body;

  const query = `
    UPDATE Products
    SET price = ?
    WHERE productID = ?;
  `;

  try {
    await db.query(query, [price, productID]);
    res.redirect('/products');
  } catch (err) {
    console.error('Error updating product:', err);
    res.status(500).send('Database update error');
  }
});

app.post('/products/delete', async (req, res) => {
  const { productID } = req.body;

  const query = `
    DELETE FROM Products
    WHERE productID = ?;
  `;

  try {
    await db.query(query, [productID]);
    res.redirect('/products');
  } catch (err) {
    console.error('Error deleting product:', err);
    res.status(500).send('Database delete error');
  }
});

app.post('/orders/add', async (req, res) => {
  const { orderDate, shippingAddress, orderTotal, customerID } = req.body;

  const query = `
    INSERT INTO Orders (orderDate, shippingAddress, orderTotal, Customers_customerID)
    VALUES (?, ?, ?, ?);
  `;

  try {
    await db.query(query, [orderDate, shippingAddress, orderTotal, customerID]);
    res.redirect('/orders');
  } catch (err) {
    console.error('Error adding order:', err);
    res.status(500).send('Error adding order');
  }
});

app.post('/orders/update', async (req, res) => {
  const { orderID, orderDate } = req.body;

  const query = `
    UPDATE Orders
    SET orderDate = ?
    WHERE orderID = ?;
  `;

  try {
    await db.query(query, [orderDate, orderID]);
    res.redirect('/orders');
  } catch (err) {
    console.error('Error updating order:', err);
    res.status(500).send('Database update error');
  }
});

app.post('/orders/delete', async (req, res) => {
  const { orderID } = req.body;

  const query = `
    DELETE FROM Orders
    WHERE orderID = ?;
  `;

  try {
    await db.query(query, [orderID]);
    res.redirect('/orders');
  } catch (err) {
    console.error('Error deleting order:', err);
    res.status(500).send('Database delete error');
  }
});

app.post('/orderitems/add', async (req, res) => {
  const { orderID, productID, quantity } = req.body;

  const query = `
    INSERT INTO OrderItems (Orders_orderID, Products_productID, quantity)
    VALUES (?, ?, ?);
  `;

  try {
    await db.query(query, [orderID, productID, quantity]);
    res.redirect('/orderitems');
  } catch (err) {
    console.error('Error inserting order item:', err);
    res.status(500).send('Insert error');
  }
});

app.post('/orderitems/update', async (req, res) => {
  const { orderItemID, newOrderID, newProductID, newQuantity } = req.body;

  const query = `
    UPDATE OrderItems
    SET Orders_orderID = ?, Products_productID = ?, quantity = ?
    WHERE orderItemID = ?;
  `;

  try {
    await db.query(query, [newOrderID, newProductID, newQuantity, orderItemID]);
    res.redirect('/orderitems');
  } catch (err) {
    console.error('Error updating order item:', err);
    res.status(500).send('Update failed');
  }
});

app.post('/orderitems/delete', async (req, res) => {
  const { orderItemID } = req.body;

  const query = `
    DELETE FROM OrderItems
    WHERE orderItemID = ?;
  `;

  try {
    await db.query(query, [orderItemID]);
    res.redirect('/orderitems');
  } catch (err) {
    console.error('Error deleting order item:', err);
    res.status(500).send('Database delete error');
  }
});

// Start server 
app.listen(PORT, () => {
  console.log(`Server listening on http://classwork.engr.oregonstate.edu:${PORT}`);
});