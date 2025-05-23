/*
    # Citation for Project Step 2:
    # Date: 05/30/2025

    # Based on Project Step 2 Draft instructions:
    # Source URL: https://oregonstate.instructure.com/courses/1999601/assignments/10006385?module_item_id=25352941

    # Copied most of MySQL Workbench's forward schema table creation variables 
    # to ensure continutity.
*/

/*
    # Authors: Bryce Davenport and Jack Armstrong
    # Repository: https://github.com/Bryce-Davenport/CS340-Term-Project
*/

USE cs340_davenpbr; /*update here when changing DB*/


SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- Clear all DB Tables

DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

/*
    Creating database tables
*/

-- Create Customers Table

CREATE Table Customers (
  customerID INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(355) NOT NULL,
  streetAddress VARCHAR(255) NOT NULL,
  phoneNumber VARCHAR(15) NULL,
  PRIMARY KEY (customerID)
);

-- Create Orders Table

CREATE Table Orders (
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

CREATE Table Products (
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

CREATE Table OrderItems (
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

/*
    Inserting sample data into database
*/

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
    (SELECT customerID FROM Customers WHERE email = "jordan.miles42@example.com")
),
(
    "2025-04-17",
    "1342 NE Davis St, Portland, OR 97232",
    89.50,
    (SELECT customerID FROM Customers WHERE email = "jordan.miles42@example.com")
),
(
    "2025-04-18",
    "415 River Rd, Medford, OR 97501",
    249.75,
    (SELECT customerID FROM Customers WHERE email = "natalie.wren13@samplemail.com")
),
(
    "2025-04-21",
    "9015 SW Barbur Blvd, Portland, OR 97219",
    59.99,
    (SELECT customerID FROM Customers WHERE email = "carter.blake@fakemail.net")
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

SET FOREIGN_KEY_CHECKS=1;
COMMIT;