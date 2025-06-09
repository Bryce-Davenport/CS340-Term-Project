/*
    # Authors: Bryce Davenport and Jack Armstrong
    # Repository: https://github.com/Bryce-Davenport/CS340-Term-Project
*/

-- CUSTOMERS
-- =====================================================

-- View all customers
SELECT customerID, email, streetAddress, phoneNumber FROM Customers;

-- Insert a new customer
INSERT INTO Customers (email, streetAddress, phoneNumber)
VALUES (c_email, c_streetAddress, c_phoneNumber);

-- Update customer phone and email
UPDATE Customers
SET phoneNumber = c_newPhoneNumber,
email = c_newEmail
WHERE customerID = c_customerID;

-- Delete a customer
DELETE FROM Customers WHERE customerID = c_customer_id;

-- PRODUCTS
-- =====================================================

-- View all products
SELECT productID, manufacturer, model, productType, color, price FROM Products;

-- Insert a new product
INSERT INTO Products (manufacturer, model, productType, color, price)
VALUES (p_manufacturer, p_model, p_productType, p_color, p_price);

-- Update product price
UPDATE Products
    SET price = p_newPrice
WHERE productID = p_product_id;

-- Delete a product
DELETE FROM Products
WHERE productID = p_productID;

-- ORDERS
-- =====================================================

-- View all orders
SELECT o.orderID, o.orderDate, o.shippingAddress, o.orderTotal,
       c.customerID, c.email
FROM Orders o
JOIN Customers c ON o.Customers_customerID = c.customerID;

-- Insert a new order
INSERT INTO Orders (orderDate, shippingAddress, orderTotal, Customers_customerID)
VALUES (o_orderDate, o_shippingAddress, o_orderTotal, o_customerID);

-- Update order date
UPDATE Orders
SET orderDate = o_newOrderDate
WHERE orderID = o_orderID;

-- Delete an order
DELETE FROM Orders
WHERE orderID = o_orderID;


-- OrderItems (Join Table)
-- =====================================================

-- View all OrderItems with order and product info 
SELECT oi.orderItemID, oi.quantity,
       o.orderID, o.orderDate,
       p.productID, p.model, p.price
FROM OrderItems oi
JOIN Orders o ON oi.Orders_orderID = o.orderID
JOIN Products p ON oi.Products_productID = p.productID;

-- Insert a product into orderItems
INSERT INTO OrderItems (Orders_orderID, Products_productID, quantity)
VALUES (oi_orderID, oi_productID, oi_quantity);

-- Update quantity of product in orderItems
UPDATE OrderItems
SET Orders_orderID = oi_newOrderID, Products_productID = oi_newProductID, quantity = oi_newQuantity
WHERE orderItemID = oi_orderItemID;

-- Remove a product from orderItems
DELETE FROM OrderItems
WHERE orderItemID = oi_orderItemID;


-- Dropdown Queries for Foreign Key Selection
-- =====================================================

-- Get all customers for dropdown (used when creating an order)
SELECT customerID, email FROM Customers;

-- Get all orders for dropdown (used when creating order items)
SELECT orderID, orderDate FROM Orders;

-- Get all products for dropdown (used when creating order items)
SELECT productID, model FROM Products;