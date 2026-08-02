/*=====================================================
SECTION 1 : BASIC SALES ANALYSIS
Objective: Understand the overall sales performance.
=====================================================*/

-- Calculate Total Sales
SELECT SUM(TotalAmount) AS TotalSales
FROM amazon_cleaned;
-- Calculate Average order value
SELECT AVG(TotalAmount) AS AverageOrderValue
FROM amazon_cleaned;
-- Calculate maximum order amount
SELECT MAX(TotalAmount) AS HighestOrder
FROM amazon_cleaned;
-- Calculate minimum order amount
SELECT MIN(TotalAmount) AS LowestOrder
FROM amazon_cleaned;
