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
    await db.query('CALL sp_load_computerStoreDB')
    res.render('index'); 
  } catch (err) {
    console.error('Error resetting database:', err);
    res.status(500).send('Error resetting database');
  }
});

// Customers CUD
app.get('/customers', async (req, res) => {
  try {
    const [[customers]] = await db.query(
      `CALL sp_view_customers`
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

  const query = `CALL sp_add_customers(?, ?, ?)`;

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

  const query = `CALL sp_update_customers(?, ?, ?)`;

  try {
    await db.query(query, [customerID, email, phoneNumber]);
    res.redirect('/customers');
  } catch (err) {
    console.error('Error updating customer:', err);
    res.status(500).send('Database update error');
  }
});

app.post('/customers/delete', async (req, res) => {
  const { customerID } = req.body;

  const query = `CALL sp_delete_customers(?)`;

  try {
    await db.query(query, [customerID]);
    res.redirect('/customers');
  } catch (err) {
    console.error('Error deleting customer:', err);
    res.status(500).send('Database delete error');
  }
});

// Products CUD 
app.get('/products', async (req, res) => {
    try {
    const [[products]] = await db.query(
      `CALL sp_view_products`
    );

    res.render('products', {
      products: products
    });
  } catch (err) {
    console.error('Error loading products:', err);
    res.status(500).send('Error loading products');
  }
});

app.post('/products/add', async (req, res) => {
  const { manufacturer, model, productType, color, price } = req.body;

  const query = `CALL sp_add_products(?, ?, ?, ?, ?)`;

  try {
    await db.query(query, [manufacturer, model, productType, color, price]);
    res.redirect('/products');
  } catch (err) {
    console.error('Error adding product:', err);
    res.status(500).send('Error adding product');
  }
});

app.post('/products/update', async (req, res) => {
  const { price, productID } = req.body;

  const query = `CALL sp_update_products(?, ?)`;

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

  const query = `CALL sp_delete_products(?)`;

  try {
    await db.query(query, [productID]);
    res.redirect('/products');
  } catch (err) {
    console.error('Error deleting product:', err);
    res.status(500).send('Database delete error');
  }
});

// Orders CUD
app.get('/orders', async (req, res) => {
  try {
    const [[customers]] = await db.query(
      `CALL sp_view_customerOrders`
    );

    const [[orders]] = await db.query(
      `CALL sp_view_orders`
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

app.post('/orders/add', async (req, res) => {
  const { orderDate, shippingAddress, orderTotal, customerID } = req.body;

  const query = `CALL sp_add_orders(?, ?, ?, ?)`;

  try {
    await db.query(query, [orderDate, shippingAddress, orderTotal, customerID]);
    res.redirect('/orders');
  } catch (err) {
    console.error('Error adding order:', err);
    res.status(500).send('Error adding order');
  }
});

app.post('/orders/update', async (req, res) => {
  const { orderDate, orderID } = req.body;

  const query = `CALL sp_update_orders(?, ?)`;

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

  const query = `CALL sp_delete_orders(?)`;

  try {
    await db.query(query, [orderID]);
    res.redirect('/orders');
  } catch (err) {
    console.error('Error deleting order:', err);
    res.status(500).send('Database delete error');
  }
});

// orderItems CUD
app.get('/orderitems', async (req, res) => {
  try {
    const [[orderitems]] = await db.query(`CALL sp_view_orderItems()`);

    const [[orders]] = await db.query(`CALL sp_view_order_OrderItems()`);
    const [[products]] = await db.query(`CALL sp_view_product_OrderItems()`);

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

app.post('/orderitems/add', async (req, res) => {
  const { orderID, productID, quantity } = req.body;

  const query = `CALL sp_add_orderItems(?, ?, ?)`;

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

  const query = `CALL sp_update_orderItems(?, ?, ?, ?)`;

  try {
    await db.query(query, [orderItemID, newOrderID, newProductID, newQuantity]);
    res.redirect('/orderitems');
  } catch (err) {
    console.error('Error updating order item:', err);
    res.status(500).send('Update failed');
  }
});

app.post('/orderitems/delete', async (req, res) => {
  const { orderItemID } = req.body;

  const query = `CALL sp_delete_orderItems(?)`;

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