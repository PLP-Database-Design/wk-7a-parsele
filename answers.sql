-- Question 1: Achieving 1NF
-- Split the Products column into individual rows
CREATE TABLE ProductDetail_1NF AS
SELECT 
  OrderID,
  CustomerName,
  TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', numbers.n), ',', -1)) AS Product
FROM ProductDetail
CROSS JOIN (
  SELECT 1 AS n UNION ALL
  SELECT 2 UNION ALL
  SELECT 3 UNION ALL
  SELECT 4
) numbers
WHERE numbers.n <= LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) + 1;

-- Question 2: Achieving 2NF
-- Split the table to eliminate partial dependencies
-- Step 1: Create Orders table
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(255)
);

-- Step 2: Create OrderProducts table
CREATE TABLE OrderProducts (
  OrderID INT,
  Product VARCHAR(255),
  Quantity INT,
  PRIMARY KEY (OrderID, Product),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Populate Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Step 4: Populate OrderProducts table
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
