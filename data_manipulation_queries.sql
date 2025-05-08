
-- CUSTOMERS
-- =====================================================

-- View all customers
SELECT * FROM Customers;

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
SELECT * FROM Products;

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
SELECT * FROM Orders;

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

-- View all products in an order
SELECT p.model, p.price, oi.quantity
FROM OrderItems oi
JOIN Products p ON oi.Products_productID = p.productID
WHERE oi.Orders_orderID = @order_id;

-- Insert product into order
INSERT INTO OrderItems (Orders_orderID, Products_productID, quantity, itemPrice)
VALUES (@order_id, @product_id, @quantity, @item_price);

-- Update quantity of product in an order
UPDATE OrderItems
SET quantity = @new_quantity,
    itemPrice = @new_price
WHERE Orders_orderID = @order_id AND Products_productID = @product_id;

-- Remove a product from an order
DELETE FROM OrderItems
WHERE Orders_orderID = @order_id AND Products_productID = @product_id;