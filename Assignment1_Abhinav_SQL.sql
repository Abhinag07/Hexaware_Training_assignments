-- 1. Create the database named "TechShop"
CREATE DATABASE TechShop;

-- 2. Use the "TechShop" database
USE TechShop;

-- Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

-- Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2)
);

-- Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Inventory table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- a. Insert into Customers table
INSERT INTO Customers VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '4856132', '123 Main St'),
(2, 'jack', 'nin', 'jacknin@email.com', '1562542', '12 Main St'),
(3, 'honey', 'min', 'honey@email.com', '153265431', '13 Main St'),
(4, 'gin', 'ree', 'ginree@email.com', '8415623', '1238 Main St'),
(5, 'min', 'dee', 'deemin@email.com', '150254962', '12314 Main St'),
(6, 'tin', 'oni', 'tinoni@email.com', '95281445', '123 JAvk St'),
(7, 'folom', 'pae', 'folompae@email.com', '123-456-54', '1 Main St'),
(8, 'hon', 'haen', 'honhaen@email.com', '12551', '32 Hill St'),
(9, 'Bun', 'will', 'bunwill@email.com', '123-151510', '58463 St of chicago'),
(10, 'Tonn', 'jil', 'tonnjil@email.com', '45411890', '111 sTreeet');

-- b. Insert into Products table
INSERT INTO Products VALUES
(10, 'Laptop', 'laptop for work and gaming', 29999.99),
(20, 'mobile', 'Powerful strong', 10999.99),
(30, 'charger', 'useful', 199.99),
(40, 'wifi router', 'greater speed', 1205.99),
(50, 'modem', 'good coonectivity', 999.99),
(60, 'Cable', 'usb and wires', 99.99),
(70, 'TV', 'A1 display', 97599.99),
(80, 'Refrigerator', 'Powerful cooling', 58999.99),
(90, 'AC', 'feel like winters', 49999.99),
(100, 'Fan', 'energy saving', 999.99);

-- c. Insert into Orders table
INSERT INTO Orders VALUES
(111, 1, '2023-01-01', 9999.99),
(222, 3, '2023-01-11', 95899.99),
(333, 5, '2023-11-01', 9991.99),
(444, 9, '2023-05-08', 99974.99),
(555, 10, '2023-01-09', 4719.99),
(666, 10, '2023-10-10', 8999.99),
(777, 1, '2023-10-14', 12999.99),
(888, 5, '2023-07-31', 95299.99),
(999, 2, '2023-04-04', 854.99),
(1111, 7, '2023-09-01', 1423.99);

-- d. Insert into OrderDetails table
INSERT INTO OrderDetails VALUES
(101, 1111, 20, 2),
(102, 666, 20, 5),
(103, 222, 30, 6),
(104, 222, 40, 4),
(105, 111, 70, 4),
(106, 222, 60, 4),
(107, 777, 10, 6),
(108, 555, 60, 7),
(109, 777, 10, 8),
(1010, 444, 90, 10);

-- e. Insert into Inventory table
INSERT INTO Inventory VALUES
(1001, 10, 101, '2023-01-01'),
(1002, 40, 102, '2021-02-21'),
(1003, 50, 291, '2022-01-05'),
(1004, 50, 310, '2022-02-01'),
(1005, 70, 150, '2023-07-07'),
(1006, 60, 184, '2020-01-09'),
(1007, 90, 420, '2023-01-11'),
(1008, 40, 456, '2021-01-11'),
(1009, 30, 302, '2023-01-05'),
(10010, 10, 257, '2022-01-01');



SELECT FirstName, LastName, Email FROM Customers;
SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;


INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES (11,'joe', 'dan', 'jdan@email.com', '555-123-4567', '789 Pine St');

INSERT INTO Products VALUES
(110, 'Electronic gadget', 'energy saving', 99999.99);

UPDATE Products SET Price = Price * 1.1 WHERE ProductName = 'Electronic gadget';


DECLARE @OrderIDToDelete INT = 333; 
DELETE FROM OrderDetails WHERE OrderID = @OrderIDToDelete;
DELETE FROM Orders WHERE OrderID = @OrderIDToDelete;

INSERT INTO Orders VALUES (1112, 5, '2023-03-15', 1299.99); 

DECLARE @CustomerIDToUpdate INT = 6; 
UPDATE Customers SET Email = 'onitim@email.com', Address = '456 newc St'
WHERE CustomerID = @CustomerIDToUpdate;

UPDATE Orders
SET TotalAmount = (
    SELECT SUM(Products.Price * OrderDetails.Quantity)
    FROM OrderDetails
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
    WHERE OrderDetails.OrderID = Orders.OrderID
)

DECLARE @CustomerIDToDelete INT = 9; 
DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @CustomerIDToDelete);
DELETE FROM Orders WHERE CustomerID = @CustomerIDToDelete;

ALTER TABLE Orders
ADD Status varchar(50);

DECLARE @OrderIDToUpdate INT = 888; 
UPDATE Orders SET Status = 'Shipped' WHERE OrderID = @OrderIDToUpdate;



ALTER TABLE Customers
ADD TotalOrders INT;

UPDATE Customers SET TotalOrders = ( 
SELECT COUNT(*) FROM Orders WHERE
Orders.CustomerID=Customers.CustomerID);

SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
FROM Orders JOIN Customers ON Orders.CustomerID = Customers.CustomerID;


SELECT Products.ProductName, SUM(Products.Price * OrderDetails.Quantity) AS TotalRevenue
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName;

SELECT DISTINCT Customers.CustomerID, Customers.FirstName, Customers.LastName, 
Customers.Email, Customers.Phone, Customers.Address
FROM Customers JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT TOP 1 Products.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantityOrdered
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalQuantityOrdered DESC;

SELECT ProductName, Description
FROM Products;

SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, AVG(Orders.TotalAmount) AS AverageOrderValue
FROM Customers JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName;

SELECT TOP 1 Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName, SUM(Products.Price * OrderDetails.Quantity) AS TotalRevenue
FROM Orders JOIN Customers ON Orders.CustomerID = Customers.CustomerID JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID GROUP BY Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
ORDER BY TotalRevenue DESC;

SELECT Products.ProductName, COUNT(OrderDetails.ProductID) AS OrderCount
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName;


DECLARE @ProductNameParameter VARCHAR(100) = 'Cable'; 
SELECT Customers.FirstName, Customers.LastName, Customers.Email
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.ProductName = @ProductNameParameter;

DECLARE @StartDate DATE = '2023-01-01'; 
DECLARE @EndDate DATE = '2023-12-31'; 
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders
WHERE OrderDate BETWEEN @StartDate AND @EndDate;

SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NULL;

SELECT CustomerID, FirstName, LastName
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

SELECT (SELECT COUNT(*) FROM Products) AS TotalProducts;


SELECT (SELECT SUM(TotalAmount) FROM Orders) AS TotalRevenue;

DECLARE @CategoryName VARCHAR(100) = 'Laptop';
SELECT AVG(Quantity) AS AverageQuantityOrdered
FROM (
    SELECT OrderDetails.Quantity
    FROM OrderDetails
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
    WHERE Products.ProductName = @CategoryName
) AS Res;

DECLARE @CustomerIDParameter INT = 1;
SELECT (SELECT SUM(TotalAmount) FROM Orders WHERE CustomerID = @CustomerIDParameter) AS TotalRevenue;

SELECT TOP 1 FirstName, LastName, OrderCount
FROM (
    SELECT Customers.FirstName, Customers.LastName, COUNT(Orders.OrderID) AS OrderCount
    FROM Customers
    LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName
)AS SUB ORDER BY OrderCount DESC;

SELECT TOP 1  ProductName, TotalQuantityOrdered
FROM (
    SELECT Products.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantityOrdered
    FROM OrderDetails
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
    GROUP BY Products.ProductName
) AS Subquery
ORDER BY TotalQuantityOrdered DESC;

SELECT TOP 1 FirstName, LastName, TotalSpending
FROM (
    SELECT Customers.FirstName, Customers.LastName, SUM(Products.Price * OrderDetails.Quantity) AS TotalSpending
    FROM Customers
    JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
    WHERE Products.ProductName = 'Laptop'
    GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName
) AS Subquery
ORDER BY TotalSpending DESC;


SELECT (SELECT AVG(TotalAmount) FROM Orders) AS AverageOrderValue;

SELECT CustomerID, FirstName, LastName, OrderCount
FROM (
    SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, COUNT(Orders.OrderID) AS OrderCount
    FROM Customers
    LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName
) AS Subquery;



