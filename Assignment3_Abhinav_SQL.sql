--TASK 1
CREATE DATABASE HMBank;
USE HMBank;


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    DOB DATE,
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE SET NULL
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(20),
    amount DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) ON DELETE SET NULL
);

--TASK 2
INSERT INTO Customers VALUES
(1, 'Rahul', 'Sharma', '1990-05-15', 'rahul.sharma@email.com', '9876543210', 'Delhi'),
(2, 'Priya', 'Patel', '1985-08-22', 'priya.patel@email.com', '8765432109', 'Mumbai'),
(3, 'Amit', 'Singh', '1988-04-12', 'amit.singh@email.com', '7654321098', 'Kolkata'),
(4, 'Deepa', 'Shah', '1995-09-28', 'deepa.shah@email.com', '6543210987', 'Chennai'),
(5, 'Rajesh', 'Kumar', '1977-12-05', 'rajesh.kumar@email.com', '5432109876', 'Hyderabad'),
(6, 'Anita', 'Gupta', '1982-03-20', 'anita.gupta@email.com', '4321098765', 'Bangalore'),
(7, 'Suresh', 'Verma', '1992-06-18', 'suresh.verma@email.com', '3210987654', 'Mumbai'),
(8, 'Preeti', 'Agarwal', '1980-11-15', 'preeti.agarwal@email.com', '2109876543', 'Delhi'),
(9, 'Vikram', 'Rajput', '1993-02-25', 'vikram.rajput@email.com', '1098765432', 'Chandigarh'),
(10, 'Neha', 'Sharma', '1986-07-30', 'neha.sharma@email.com', '9876543210', 'Jaipur');

INSERT INTO Accounts VALUES
(101, 1, 'savings', 5000.00),
(102, 10, 'zero_balance', 10000.00),
(103, 2, 'savings', 8000.00),
(104, 3, 'current', 12000.00),
(105, 4, 'savings', 6000.00),
(106, 5, 'zero_balance', 15000.00),
(107, 6, 'savings', 7000.00),
(108, 7, 'current', 18000.00),
(109, 8, 'zero_balance', 9000.00),
(110, 9, 'current', 20000.00);

INSERT INTO Transactions VALUES
(1001, 101, 'deposit', 2000.00, '2023-01-10'),
(1002, 101, 'withdrawal', 1000.00, '2023-02-15'),
(1003, 107, 'deposit', 3000.00, '2023-03-20'),
(1004, 102, 'withdrawal', 1500.00, '2023-04-25'),
(1005, 104, 'deposit', 2500.00, '2023-05-10'),
(1006, 103, 'withdrawal', 1200.00, '2023-06-15'),
(1007, 104, 'deposit', 4000.00, '2023-07-05'),
(1008, 109, 'withdrawal', 2000.00, '2023-08-18'),
(1009, 105, 'deposit', 3500.00, '2023-09-22'),
(1010, 105, 'withdrawal', 1800.00, '2023-10-30');
 
 --SQL query to retrieve the names and emails of all customers

SELECT first_name, last_name, account_type, email FROM Customers, Accounts;
--SELECT first_name, last_name, account_type, email FROM Customers, Accounts 
--WHERE Customers.customer_id = Accounts.customer_id;

--SQL query to list all the transactions corresponding customer

SELECT * FROM Transactions
JOIN Accounts ON Transactions.account_id = Accounts.account_id
JOIN Customers ON Accounts.customer_id = Customers.customer_id;

--sql query to increase the balance of a specific account by a certain amount

UPDATE Accounts SET balance = balance + 700 WHERE account_id = 102;

--sql query to combine first and last names of customers as a full name.

SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM Customers;

--sql query to remove accounts with a balance of zero where the account type is savings

DELETE FROM Accounts WHERE balance = 0 AND account_type = 'savings';
SELECT * FROM Accounts;

--sql query to find customers living in a specific city.

SELECT * FROM Customers WHERE address = 'Mumbai';

--  SQL query to Get the account balance for a specific account.

SELECT balance FROM Accounts WHERE account_id = 102;

--SQL query to List all current accounts with a balance greater than $1,000.
SELECT * FROM Accounts WHERE account_type = 'current' AND balance > 1000;

--SQL query to Retrieve all transactions for a specific account.
SELECT * FROM Transactions WHERE account_id = 101;

--SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.
SELECT account_id, balance * 0.05 AS interest_accrued FROM Accounts WHERE account_type = 'savings';

-- SQL query to Identify accounts where the balance is less than a specified overdraft limit.
SELECT * FROM Accounts WHERE balance < 500;

--SQL query to Find customers not living in a specific city.
SELECT * FROM Customers WHERE address != 'Delhi';



--TASK 3

-- SQL query to Find the average account balance for all customers. 
SELECT AVG(balance) AS average_balance
FROM Accounts;

--SQL query to Retrieve the top 10 highest account balances.
SELECT TOP 10 *
FROM accounts
ORDER BY balance DESC;

--SQL query to Calculate Total Deposits for All Customers in specific date.
SELECT c.customer_id, c.first_name, SUM(t.amount) AS total_deposits
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
WHERE t.transaction_type = 'deposit' AND CONVERT(DATE, t.transaction_date) = '2023-05-10'
GROUP BY c.customer_id, c.first_name;

-- SQL query to Find the Oldest and Newest Customers.



-- SQL query to Retrieve transaction details along with the account type.
SELECT
    t.transaction_id,
    t.transaction_date,
    t.amount,
    t.transaction_type,
    a.account_type
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id;

--  SQL query to Get a list of customers along with their account details.
SELECT
    c.customer_id,
    c.first_name,
    a.account_id,
    a.account_type,
    a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id;

--SQL query to Retrieve transaction details along with customer information for a specific account.
SELECT
    t.transaction_id,
    t.transaction_date,
    t.amount,
    t.transaction_type,
    c.customer_id,
    c.first_name,
    a.account_id,
    a.account_type,
    a.balance
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
WHERE a.account_id = '104';

--SQL query to Identify customers who have more than one account.
SELECT
    c.customer_id,
    c.first_name,
    COUNT(a.account_id) AS number_of_accounts
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name
HAVING COUNT(a.account_id) > 1;
--SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.
SELECT
    t.account_id,
    SUM(CASE WHEN t.transaction_type = 'Deposit' THEN t.amount ELSE -t.amount END) AS difference_amount
FROM transactions t
GROUP BY t.account_id;

--a SQL query to Calculate the average daily balance for each account over a specified period.
SELECT
    t.account_id,
    AVG(t.amount) AS average_daily_balance
FROM transactions t
WHERE t.transaction_date BETWEEN '2023-01-10' AND '2023-10-30'
GROUP BY t.account_id;

-- Calculate the total balance for each account type.
SELECT
    a.account_type,
    SUM(t.amount) AS total_balance
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
GROUP BY a.account_type;

-- Identify accounts with the highest number of transactions order by descending order.

SELECT
    a.account_id,
    COUNT(t.transaction_id) AS transaction_count
FROM accounts a
JOIN transactions t ON a.account_id = t.account_id
GROUP BY a.account_id
ORDER BY transaction_count DESC;

-- List customers with high aggregate account balances, along with their account types.
SELECT
    c.customer_id,
    c.first_name,
    a.account_type,
    SUM(t.amount) AS aggregate_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.customer_id, c.first_name, a.account_type
ORDER BY aggregate_balance DESC;

-- Identify and list duplicate transactions based on transaction amount, date, and account.






--Task 4

-- 1
SELECT TOP 1 c.customer_id, c.first_name, c.last_name, MAX(a.balance) AS highest_balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY highest_balance DESC;


-- 2

SELECT AVG(sub.avg_balance) AS average_balance
FROM (
    SELECT c.customer_id, AVG(a.balance) AS avg_balance
    FROM Customers c
    JOIN Accounts a ON c.customer_id = a.customer_id
    GROUP BY c.customer_id
    HAVING COUNT(a.account_id) > 1
) AS sub;




--  3
SELECT a.*, t.*
FROM Accounts a
JOIN Transactions t ON a.account_id = t.account_id
WHERE t.amount > (SELECT AVG(amount) FROM Transactions);

--4
SELECT c.*
FROM Customers c
LEFT JOIN Accounts a ON c.customer_id = a.customer_id
LEFT JOIN Transactions t ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;

--5

SELECT SUM(a.balance) AS total_balance
FROM Accounts a
LEFT JOIN Transactions t ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;


--6

SELECT t.*
FROM Transactions t
JOIN (
    SELECT TOP 1 a.account_id
    FROM Accounts a
    ORDER BY a.balance ASC
) AS lowest_balance_account ON t.account_id = lowest_balance_account.account_id;


--7

SELECT c.customer_id, c.first_name, c.last_name, COUNT(DISTINCT a.account_type) AS account_types_count
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT a.account_type) > 1;





--8
SELECT account_type,
       COUNT(*) AS num_accounts,
       ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Accounts)), 2) AS percentage
FROM Accounts
GROUP BY account_type;




--9
SELECT * FROM Transactions
WHERE account_id IN (SELECT account_id FROM Accounts 
WHERE customer_id = 1
);




--10
SELECT account_type,
       (SELECT SUM(balance) FROM Accounts A WHERE A.account_type = Accounts.account_type) AS total_balance
FROM Accounts
GROUP BY account_type;