/*==========================================================
SECTION 2 : BUSINESS ANALYSIS

Objective:
Answer business questions using SQL.

==========================================================*/
-- Category analysis
SELECT Category,SUM(TotalAmount) AS Sales
FROM amazon_cleaned
GROUP BY Category
ORDER BY Sales DESC;

-- Top 10 products
SELECT
ProductName,
SUM(TotalAmount) AS Sales
FROM amazon_cleaned
GROUP BY ProductName
ORDER BY Sales DESC
LIMIT 10;

-- Top brands
SELECT
Brand,
SUM(TotalAmount) AS Sales
FROM amazon_cleaned
GROUP BY Brand
ORDER BY Sales DESC;

-- Top Customers
SELECT
CustomerName,
SUM(TotalAmount) AS TotalSpent
FROM amazon_cleaned
GROUP BY CustomerName
ORDER BY TotalSpent DESC
LIMIT 10;

-- Sales by Country
SELECT
Country,
SUM(TotalAmount) AS Sales
FROM amazon_cleaned
GROUP BY Country
ORDER BY Sales DESC;

-- Sales by State
SELECT
State,
SUM(TotalAmount) AS Sales
FROM amazon_cleaned
GROUP BY State
ORDER BY Sales DESC;

-- Sales by City
SELECT
City,
SUM(TotalAmount) AS Sales
FROM amazon_cleaned
GROUP BY City
ORDER BY Sales DESC;

-- Payment method analysis
SELECT
PaymentMethod,
COUNT(*) AS TotalOrders
FROM amazon_cleaned
GROUP BY PaymentMethod
ORDER BY TotalOrders DESC;

-- Order status analysis
SELECT
OrderStatus,
COUNT(*) AS TotalOrders
FROM amazon_cleaned
GROUP BY OrderStatus
ORDER BY TotalOrders DESC;

-- Monthly Sales trend
SELECT Year,Month,
SUM(TotalAmount) AS Sales
FROM amazon_cleaned
GROUP BY Year, Month
ORDER BY Year, Month;

-- Yearly sales trend
SELECT
Year,
SUM(TotalAmount) AS Sales
FROM amazon_cleaned
GROUP BY Year
ORDER BY Year;