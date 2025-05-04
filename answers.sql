-- Achieving 1NF by splitting the Products into individual rows
SELECT OrderID, CustomerName, 'Laptop' AS Product FROM ProductDetail WHERE Products LIKE '%Laptop%' 
UNION
SELECT OrderID, CustomerName, 'Mouse' AS Product FROM ProductDetail WHERE Products LIKE '%Mouse%'
UNION
SELECT OrderID, CustomerName, 'Tablet' AS Product FROM ProductDetail WHERE Products LIKE '%Tablet%'
UNION
SELECT OrderID, CustomerName, 'Keyboard' AS Product FROM ProductDetail WHERE Products LIKE '%Keyboard%'
UNION
SELECT OrderID, CustomerName, 'Phone' AS Product FROM ProductDetail WHERE Products LIKE '%Phone%';



-- Creating a table for Orders to store OrderID and CustomerName
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Insert data into the Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Creating the normalized OrderDetails table
CREATE TABLE OrderDetails (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into the OrderDetails table
INSERT INTO OrderDetails (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;
