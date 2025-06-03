/*
    # Citation for Project Step 4:
    # Date: 05/22/2025

    # Based on: PL/SQL part 2, Stored Procedures for CUD
    # Source URL: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-pl-slash-sql-part-2-stored-procedures-for-cud?module_item_id=25352959

    # Used the skeleton of the moviesDB to create the SP
*/
DROP PROCEDURE IF EXISTS sp_load_computerStoreDB;
DELIMITER //

CREATE PROCEDURE sp_load_computerStoreDB()
BEGIN
    SET FOREIGN_KEY_CHECKS=0;
    SET AUTOCOMMIT = 0;

    -- Clear all DB Tables

    DROP TABLE IF EXISTS OrderItems;
    DROP TABLE IF EXISTS Products;
    DROP TABLE IF EXISTS Orders;
    DROP TABLE IF EXISTS Customers;

    -- -----------------------------------------------------
    -- Creating database tables
    -- -----------------------------------------------------

    -- Create Customers Table

    CREATE Table IF NOT EXISTS Customers (
    customerID INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(355) NOT NULL,
    streetAddress VARCHAR(255) NOT NULL,
    phoneNumber VARCHAR(15) NULL,
    PRIMARY KEY (customerID)
    );

    -- Create Orders Table

    CREATE Table IF NOT EXISTS Orders (
    orderID INT NOT NULL AUTO_INCREMENT,
    orderDate DATE NOT NULL,
    shippingAddress VARCHAR(255) NOT NULL,
    orderTotal DECIMAL(10,2) NOT NULL,
    Customers_customerID INT NOT NULL,
    PRIMARY KEY (orderID),
    CONSTRAINT FK_Orders_customerID FOREIGN KEY (Customers_customerID)
    REFERENCES Customers (customerID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    );

    -- Create Products Table

    CREATE Table IF NOT EXISTS Products (
    productID INT NOT NULL AUTO_INCREMENT,
    manufacturer VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    productType VARCHAR(50) NOT NULL,
    color VARCHAR(25) NULL,
    price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (productID)
    );

    -- Start Product ID AUTO_INCREMENT at 101

    ALTER TABLE Products AUTO_INCREMENT=101;

    -- Create OrderItems Table (Junction Table)

    CREATE Table IF NOT EXISTS OrderItems (
    orderItemID INT NOT NULL AUTO_INCREMENT,
    quantity INT NOT NULL,
    Orders_orderID INT NOT NULL,
    Products_productID INT NOT NULL,
    PRIMARY KEY (orderItemID),
    CONSTRAINT FK_OrderItems_orderID FOREIGN KEY (Orders_orderID)
    REFERENCES Orders (orderID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
    CONSTRAINT FK_OrderItems_productID FOREIGN KEY (Products_productID)
    REFERENCES Products (productID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    );

    -- -----------------------------------------------------
    --    Inserting sample data into database
    -- -----------------------------------------------------

    -- Insert Customers data

    INSERT INTO Customers (
        email,
        streetAddress,
        phoneNumber
    )
    VALUES (
        "jordan.miles42@example.com",
        "St, Portland, OR 97232",
        "5034217742"
    ),
    (
        "emily.ross88@testmail.org",
        "278 Oakway Rd, Eugene, OR 97401",
        "5416859931"
    ),
    (
        "carter.blake@fakemail.net",
        "9015 SW Barbur Blvd, Portland, OR 97219",
        "9713031185"
    ),
    (
        "natalie.wren13@samplemail.com",
        "415 River Rd, Medford, OR 97501",
        "4582126790"
    ),
    (
        "theo.jenkins21@mockinbox.io",
        "1680 Commercial St SE, Salem, OR 97302",
        "5037778402"
    );
    COMMIT;

    -- Insert Orders data

    INSERT INTO Orders (
        orderDate,
        shippingAddress,
        orderTotal,
        Customers_customerID
    )
    VALUES (
        "2025-04-15",
        "1342 NE Davis St, Portland, OR 97232",
        149.99,
        (SELECT customerID FROM Customers WHERE email = "jordan.miles42@example.com" LIMIT 1)
    ),
    (
        "2025-04-17",
        "1342 NE Davis St, Portland, OR 97232",
        89.50,
        (SELECT customerID FROM Customers WHERE email = "jordan.miles42@example.com" LIMIT 1)
    ),
    (
        "2025-04-18",
        "415 River Rd, Medford, OR 97501",
        249.75,
        (SELECT customerID FROM Customers WHERE email = "natalie.wren13@samplemail.com" LIMIT 1)
    ),
    (
        "2025-04-21",
        "9015 SW Barbur Blvd, Portland, OR 97219",
        59.99,
        (SELECT customerID FROM Customers WHERE email = "carter.blake@fakemail.net" LIMIT 1)
    );

    -- Insert Products data

    INSERT INTO Products (
        manufacturer,
        model,
        productType,
        color,
        price
    )
    VALUES (
        "ASUS",
        "ROG Strix G16",
        "Laptop",
        "Black",
        999.99
    ),
    (
        "Dell",
        "OptiPlex 7010",
        "Desktop",
        "Gray",
        749.00
    ),
    (
        "Logitech",
        "MX Master 3s",
        "Mouse",
        "Graphite",
        59.99
    ),
    (
        "Keychron",
        "K8 Pro",
        "Keyboard",
        "White Backlit",
        89.50

    ),
    (
        "SanDisk",
        "Extreme 8TB",
        "SSD",
        "Red/Black",
        139.00
    );

    -- Insert OrderItems data

    INSERT INTO OrderItems (
        quantity,
        Orders_orderID,
        Products_productID
    )
    VALUES (
        1,
        1,
        101
    ),
    (
        2,
        2,
        104
    ),
    (
        1,
        2,
        102
    ),
    (
        1,
        3,
        105
    );

    COMMIT;
    SET FOREIGN_KEY_CHECKS=1;
END //

DELIMITER ;

/*
    Customers SP's
*/

-- ---------------------------------------
-- View customers stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_view_customers;

DELIMITER //

CREATE PROCEDURE sp_view_customers()
BEGIN
    SELECT customerID, email, streetAddress, phoneNumber FROM Customers;
END //

DELIMITER ;

-- ---------------------------------------
-- Add customers stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_add_customers;

DELIMITER //

CREATE PROCEDURE sp_add_customers(
  IN c_email VARCHAR(355),
  IN c_streetAddress VARCHAR(255),
  IN c_phoneNumber VARCHAR(15)
)
BEGIN
    INSERT INTO Customers (email, streetAddress, phoneNumber)
    VALUES (c_email, c_streetAddress, c_phoneNumber);
END //

DELIMITER ;

-- ---------------------------------------
-- Update customers stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_update_customers;

DELIMITER //

CREATE PROCEDURE sp_update_customers(
    IN c_customerID INT,
    IN c_newEmail VARCHAR(355),
    IN c_newPhoneNumber VARCHAR(15)
)
BEGIN
    UPDATE Customers
    SET phoneNumber = c_newPhoneNumber,
    email = c_newEmail
    WHERE customerID = c_customerID;
END //

DELIMITER ;

-- ---------------------------------------
-- Delete customers stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_delete_customers;

DELIMITER //

CREATE PROCEDURE sp_delete_customers(
    IN c_customerID INT
)
BEGIN
    DELETE FROM Customers WHERE customerID = c_customerID;
END //

DELIMITER ;

/*
    Products SP's
*/

-- ---------------------------------------
-- View products stored procedure
-- ---------------------------------------
DROP PROCEDURE IF EXISTS sp_view_products;

DELIMITER //

CREATE PROCEDURE sp_view_products()
BEGIN
    SELECT productID, manufacturer, model, productType, color, price FROM Products;
END //

DELIMITER ;

-- ---------------------------------------
-- Add products stored procedure
-- ---------------------------------------
DROP PROCEDURE IF EXISTS sp_add_products;

DELIMITER //

-- Citation for the following code:
-- Date: 06/01/25
-- Copied from /OR/ Adapted from /OR/ Based on:
-- I used copilot to generate the IN variables
-- Source URL: https://copilot.microsoft.com/
-- If AI tools were used, prompt:
--    Please generate the IN parameters for adding a product in MySQL containing the
--    manufacturer, model, productType, color, and price
CREATE PROCEDURE sp_add_products(
    IN p_manufacturer VARCHAR(255),
    IN p_model VARCHAR(255),
    IN p_productType VARCHAR(255),
    IN p_color VARCHAR(255),
    IN p_price DECIMAL(10,2)
)
BEGIN
    INSERT INTO Products (manufacturer, model, productType, color, price)
    VALUES (p_manufacturer, p_model, p_productType, p_color, p_price);
END //

DELIMITER ;

-- ---------------------------------------
-- Update products stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_update_products;

DELIMITER //

CREATE PROCEDURE sp_update_products(
    IN p_newPrice DECIMAL(10,2),
    IN p_productID INT
)
BEGIN
    UPDATE Products
        SET price = p_newPrice
    WHERE productID = p_productID;
END //

DELIMITER ;

-- ---------------------------------------
-- Delete products stored procedure
-- ---------------------------------------
DROP PROCEDURE IF EXISTS sp_delete_products;

DELIMITER //

CREATE PROCEDURE sp_delete_products(
    p_productID INT
)
BEGIN
    DELETE FROM Products
    WHERE productID = p_productID;
END //

DELIMITER ;

/*
    Orders SP's
*/

-- ---------------------------------------
-- View orders stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_view_orders;

DELIMITER //

CREATE PROCEDURE sp_view_orders()
BEGIN
    SELECT o.orderID, o.orderDate, o.shippingAddress, o.orderTotal,
       c.customerID, c.email
    FROM Orders o
    JOIN Customers c ON o.Customers_customerID = c.customerID;
END //

DELIMITER ;

-- ---------------------------------------
-- Add orders stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_add_orders;

DELIMITER //

CREATE PROCEDURE sp_add_orders(
    IN o_orderDate DATE,
    IN o_shippingAddress VARCHAR(255),
    IN o_orderTotal DECIMAL(10,2),
    IN o_customerID INT
)
BEGIN
    INSERT INTO Orders (orderDate, shippingAddress, orderTotal, Customers_customerID)
    VALUES (o_orderDate, o_shippingAddress, o_orderTotal, o_customerID);
END //

DELIMITER ;

-- ---------------------------------------
-- Update orders stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_update_orders;

DELIMITER //

CREATE PROCEDURE sp_update_orders(
    IN o_newOrderDate DATE,
    IN o_orderID INT
)
BEGIN
    UPDATE Orders
    SET orderDate = o_newOrderDate
    WHERE orderID = o_orderID;
END //

DELIMITER ;

-- ---------------------------------------
-- Delete orders stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_delete_orders;

DELIMITER //

CREATE PROCEDURE sp_delete_orders(
    IN o_orderID INT
)
BEGIN
    DELETE FROM Orders
    WHERE orderID = o_orderID;
END //

DELIMITER ;

-- ---------------------------------------
-- Dropdown Query for customerID and email from customers stored procedure
-- ---------------------------------------
DROP PROCEDURE IF EXISTS sp_view_customerOrders;
DELIMITER //

CREATE PROCEDURE sp_view_customerOrders()
BEGIN
    SELECT customerID, email FROM Customers;
END //

DELIMITER ;

/*
    orderItems SP's
*/

-- ---------------------------------------
-- View orderItems stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_view_orderItems;

DELIMITER //

CREATE PROCEDURE sp_view_orderItems()
BEGIN
    SELECT oi.orderItemID, oi.quantity,
       o.orderID, o.orderDate,
       p.productID, p.model, p.price
    FROM OrderItems oi
    JOIN Orders o ON oi.Orders_orderID = o.orderID
    JOIN Products p ON oi.Products_productID = p.productID;
END //

DELIMITER ;

-- ---------------------------------------
-- Add orderItems stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_add_orderItems;

DELIMITER //

CREATE PROCEDURE sp_add_orderItems(
    IN oi_orderID INT,
    IN oi_productID INT,
    IN oi_quantity INT
)
BEGIN
    INSERT INTO OrderItems (Orders_orderID, Products_productID, quantity)
    VALUES (oi_orderID, oi_productID, oi_quantity);
END //

DELIMITER ;

-- ---------------------------------------
-- Update orderItems stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_update_orderItems;

DELIMITER //

CREATE PROCEDURE sp_update_orderItems(
    IN oi_orderItemID INT,
    IN oi_newOrderID INT,
    IN oi_newProductID INT,
    IN oi_newQuantity INT
)
BEGIN
    SET FOREIGN_KEY_CHECKS=0;

    UPDATE OrderItems
    SET Orders_orderID = oi_newOrderID, Products_productID = oi_newProductID, quantity = oi_newQuantity
    WHERE orderItemID = oi_orderItemID;
END //

DELIMITER ;

-- ---------------------------------------
-- Delete orderItems stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_delete_orderItems;

DELIMITER //

CREATE PROCEDURE sp_delete_orderItems(
    IN oi_orderItemID INT
)
BEGIN
    DELETE FROM OrderItems
    WHERE orderItemID = oi_orderItemID;
END //

DELIMITER ;

-- ---------------------------------------
-- Dropdown Query for orderID and orderDate stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_view_order_OrderItems;
DELIMITER //

CREATE PROCEDURE sp_view_order_OrderItems()
BEGIN
    SELECT orderID, DATE_FORMAT(orderDate, '%m/%d/%Y') AS orderDate FROM Orders;
END //

DELIMITER ;

-- ---------------------------------------
-- Dropdown Query for productID and model stored procedure
-- ---------------------------------------

DROP PROCEDURE IF EXISTS sp_view_product_OrderItems;
DELIMITER //

CREATE PROCEDURE sp_view_product_OrderItems()
BEGIN
    SELECT productID, model FROM Products;
END //

DELIMITER ;