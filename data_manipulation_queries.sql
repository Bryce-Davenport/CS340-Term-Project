
-- CUSTOMERS
-- =====================================================

-- View all customers
SELECT customerID, email, streetAddress, phoneNumber FROM Customers;

-- View customer by ID
SELECT * FROM Customers WHERE customerID = @customer_id;

-- Insert a new customer
INSERT INTO Customers (email, streetAddress, phoneNumber)
VALUES (@email, @streetAddress, @phoneNumber);

-- Update customer phone and email
UPDATE Customers
SET phoneNumber = @new_phone,
    email = @new_email
WHERE customerID = @customer_id;

-- Delete a customer
DELETE FROM Customers WHERE customerID = @customer_id;


-- PRODUCTS
-- =====================================================

-- View all products
SELECT productID, manufacturer, model, productType, color, price FROM Products;

-- View product by ID
SELECT * FROM Products WHERE productID = @product_id;

-- Insert a new product
INSERT INTO Products (manufacturer, model, productType, color, price)
VALUES (@manufacturer, @model, @productType, @color, @price);

-- Update product stock and price
UPDATE Products
    SET price = @new_price
WHERE productID = @product_id;

-- Delete a product
DELETE FROM Products WHERE productID = @product_id;


-- ORDERS
-- =====================================================

-- View all orders
SELECT o.orderID, o.orderDate, o.shippingAddress, o.orderTotal,
       c.customerID, c.email
FROM Orders o
JOIN Customers c ON o.Customers_customerID = c.customerID;

-- View all orders for a customer
SELECT * FROM Orders WHERE Customers_customerID = @customer_id;

-- Insert a new order
INSERT INTO Orders (orderDate, shippingAddress, orderTotal, Customers_customerID)
VALUES (@order_date, @shippingAddress, @orderTotal, @customer_id);

-- Update order date
UPDATE Orders
SET orderDate = @new_order_date
WHERE orderID = @order_id;

-- Delete an order
DELETE FROM Orders WHERE orderID = @order_id;


-- OrderItems (Join Table)
-- =====================================================

-- View all OrderItems with order and product info 
SELECT oi.orderItemID, oi.quantity,
       o.orderID, o.orderDate,
       p.productID, p.model, p.price
FROM OrderItems oi
JOIN Orders o ON oi.Orders_orderID = o.orderID
JOIN Products p ON oi.Products_productID = p.productID;

-- View all products in an order
SELECT p.model, p.price, oi.quantity
FROM OrderItems oi
JOIN Products p ON oi.Products_productID = p.productID
WHERE oi.Orders_orderID = @order_id;

-- Insert product into order
INSERT INTO OrderItems (Orders_orderID, Products_productID, quantity)
VALUES (@order_id, @product_id, @quantity);

-- Update quantity of product in an order
UPDATE OrderItems
SET quantity = @new_quantity
WHERE Orders_orderID = @order_id AND Products_productID = @product_id;

-- Remove a product from an order
DELETE FROM OrderItems
WHERE Orders_orderID = @order_id AND Products_productID = @product_id;


-- Dropdown Queries for Foreign Key Selection
-- =====================================================

-- Get all customers for dropdown (used when creating an order)
SELECT customerID, email FROM Customers;

-- Get all orders for dropdown (used when creating order items)
SELECT orderID, orderDate FROM Orders;

-- Get all products for dropdown (used when creating order items)
SELECT productID, model FROM Products;