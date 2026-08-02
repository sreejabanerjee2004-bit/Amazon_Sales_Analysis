/*==========================================================
SECTION 4 : ADVANCED SQL

Topics Used

✓ Window Functions
✓ CTE
✓ CASE
✓ Ranking
✓ Running Total
✓ Growth Analysis

==========================================================*/

-- Rank top customers
SELECT
    CustomerName,
    SUM(TotalAmount) AS TotalSales,
    RANK() OVER(ORDER BY SUM(TotalAmount) DESC) AS CustomerRank
FROM amazon_cleaned
GROUP BY CustomerName;

-- Top 3 products in each category
WITH ProductSales AS
(
SELECT
    Category,ProductName,SUM(TotalAmount) AS Sales
FROM amazon_cleaned
GROUP BY Category, ProductName
)
SELECT *
FROM
(
SELECT *,
DENSE_RANK() OVER(PARTITION BY Category ORDER BY Sales DESC) AS Ranking
FROM ProductSales
) t
WHERE Ranking <=3;

-- Running total of sales
SELECT
    OrderDate,
    SUM(TotalAmount) AS DailySales,
    SUM(SUM(TotalAmount))
    OVER(ORDER BY OrderDate) AS RunningTotal
FROM amazon_cleaned
GROUP BY OrderDate;

-- Monthly Sales Growth
WITH MonthlySales AS
(
SELECT Year,Month,
    SUM(TotalAmount) AS Sales
FROM amazon_cleaned
GROUP BY Year, Month
)
SELECT *,
LAG(Sales) OVER(ORDER BY Year, Month) AS PreviousMonthSales,
Sales-LAG(Sales) OVER(ORDER BY Year, Month) AS Growth
FROM MonthlySales;

-- Best selling brand in each category
WITH BrandSales AS
(
SELECT Category,Brand,SUM(TotalAmount) AS Sales
FROM amazon_cleaned
GROUP BY Category,Brand
)
SELECT *
FROM
(
SELECT *,
ROW_NUMBER()
OVER(PARTITION BY Category ORDER BY Sales DESC) AS rn
FROM BrandSales
)t
WHERE rn=1;

-- Customer purchase frequency
SELECT
CustomerName,
COUNT(OrderID) AS TotalOrders,
SUM(TotalAmount) AS TotalSpent
FROM amazon_cleaned
GROUP BY CustomerName
ORDER BY TotalOrders DESC;

-- Average order value by payment method
SELECT
PaymentMethod,
ROUND(AVG(TotalAmount),2) AS AverageOrderValue
FROM amazon_cleaned
GROUP BY PaymentMethod
ORDER BY AverageOrderValue DESC;

-- Top seller 
SELECT
SellerID,
SUM(TotalAmount) AS Sales,
COUNT(OrderID) AS Orders
FROM amazon_cleaned
GROUP BY SellerID
ORDER BY Sales DESC
LIMIT 10;

-- Highest revenue city in each state
WITH CitySales AS
(
SELECT State,City,SUM(TotalAmount) AS Sales
FROM amazon_cleaned
GROUP BY State,City
)
SELECT *
FROM
(
SELECT *,
RANK() OVER(PARTITION BY State ORDER BY Sales DESC) AS Ranking
FROM CitySales
)t
WHERE Ranking=1;

-- Sales classification
SELECT ProductName,SUM(TotalAmount) AS Sales,
CASE
WHEN SUM(TotalAmount)>=150000 THEN 'High Sales'
WHEN SUM(TotalAmount)>=100000 THEN 'Medium Sales'
ELSE 'Low Sales'
END AS SalesCategory
FROM amazon_cleaned
GROUP BY ProductName;

/*==========================================================
PROJECT SUMMARY
This SQL project analyzed:

Sales Performance
Product Performance
Customer Behaviour
Regional Sales
Seller Performance
Payment Trends
Monthly Growth
Revenue Classification

Total Records Analysed : 100000

End of SQL Project
==========================================================*/