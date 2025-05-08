
-- CUSTOMERS
-- =====================================================

-- View all customers
SELECT * FROM Customers;

-- View customer by ID
SELECT * FROM Customers WHERE customer_id = @customer_id;

-- Insert a new customer
INSERT INTO Customers (first_name, last_name, email, phone)
VALUES (@first_name, @last_name, @email, @phone);

-- Update customer phone and email
UPDATE Customers
SET phone = @new_phone,
    email = @new_email
WHERE customer_id = @customer_id;

-- Delete a customer
DELETE FROM Customers WHERE customer_id = @customer_id;


-- PRODUCTS
-- =====================================================

-- View all products
SELECT * FROM Products;

-- View product by ID
SELECT * FROM Products WHERE product_id = @product_id;

-- Insert a new product
INSERT INTO Products (name, description, price, stock)
VALUES (@name, @description, @price, @stock);

-- Update product stock and price
UPDATE Products
SET stock = @new_stock,
    price = @new_price
WHERE product_id = @product_id;

-- Delete a product
DELETE FROM Products WHERE product_id = @product_id;


-- ORDERS
-- =====================================================

-- View all orders
SELECT * FROM Orders;

-- View all orders for a customer
SELECT * FROM Orders WHERE customer_id = @customer_id;

-- Insert a new order
INSERT INTO Orders (customer_id, order_date)
VALUES (@customer_id, @order_date);

-- Update order date
UPDATE Orders
SET order_date = @new_order_date
WHERE order_id = @order_id;

-- Delete an order
DELETE FROM Orders WHERE order_id = @order_id;


-- ORDER_PRODUCTS (Join Table)
-- =====================================================

-- View all products in an order
SELECT p.name, p.price, op.quantity
FROM Order_Products op
JOIN Products p ON op.product_id = p.product_id
WHERE op.order_id = @order_id;

-- Insert product into order
INSERT INTO Order_Products (order_id, product_id, quantity)
VALUES (@order_id, @product_id, @quantity);

-- Update quantity of product in an order
UPDATE Order_Products
SET quantity = @new_quantity
WHERE order_id = @order_id AND product_id = @product_id;

-- Remove a product from an order
DELETE FROM Order_Products
WHERE order_id = @order_id AND product_id = @product_id;