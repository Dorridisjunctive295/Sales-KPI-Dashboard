use sales_dashboard;
#TOTAL SALES AND PROFIT

SELECT 
    ROUND(SUM(TotalSales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM clean_superstore_sales;

#PROFIT MARGIN
SELECT 
    ROUND(SUM(Profit) / SUM(TotalSales) * 100, 2) AS Profit_Margin_Percent
FROM clean_superstore_sales;

#SALES BY REGION

SELECT 
    Region,
    ROUND(SUM(TotalSales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(TotalSales) * 100, 2) AS Profit_Margin
FROM clean_superstore_sales
GROUP BY Region
ORDER BY Total_Sales DESC;

#TOP 10 PRODUCTS BY Sales

SELECT 
    'Sub-Category',
    ROUND(SUM(TotalSales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM clean_superstore_sales
GROUP BY 'Sub-Category'
ORDER BY Total_Sales DESC
LIMIT 10;

#Monthly Sales Trend

SELECT 
    YEAR(Order_Date_Converted) AS Year,
    MONTH(Order_Date_Converted) AS Month,
    SUM(TotalSales) AS Total_Sales
FROM clean_superstore_sales
GROUP BY Year, Month;

#Category-Wise Performance

SELECT 
    Category,
    ROUND(SUM(TotalSales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(TotalSales) * 100, 2) AS Profit_Margin
FROM clean_superstore_sales
GROUP BY Category
ORDER BY Total_Sales DESC;

#creating views

CREATE VIEW v_sales_summary AS
SELECT 
    Region,
    Category,
    YEAR(Order_Date_Converted) AS Year,
    MONTH(Order_Date_Converted) AS Month,
    ROUND(SUM(TotalSales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(TotalSales) * 100, 2) AS Profit_Margin
FROM clean_superstore_sales
GROUP BY Region, Category, Year, Month;

Drop View v_sales_summary;

CREATE OR REPLACE VIEW v_sales_summary AS
SELECT 
    YEAR(Order_Date_Converted) AS Year,
    MONTH(Order_Date_Converted) AS Month,
    Region,
    Category,
    `Sub-Category` AS Sub_Category,
    Segment,
    ROUND(SUM(TotalSales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(TotalSales) * 100, 2) AS Profit_Margin_Percent,
    ROUND(AVG(AOV), 2) AS Average_Order_Value,
    COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM clean_superstore_sales
WHERE Order_Date_Converted IS NOT NULL
GROUP BY 
    YEAR(Order_Date_Converted),
    MONTH(Order_Date_Converted),
    Region,
    Category,
    `Sub-Category`,
    Segment
ORDER BY Year, Month;

SELECT * FROM v_sales_summary LIMIT 10;


#Checking views
SELECT Year, ROUND(SUM(Total_Sales), 2) AS Yearly_Sales
FROM v_sales_summary
GROUP BY Year;

Drop view v_sales_summary;

CREATE OR REPLACE VIEW v_sales_summary AS
SELECT 
    YEAR(Order_Date_Converted) AS Year,
    MONTH(Order_Date_Converted) AS Month,
    Region,
    Category,
    `Sub-Category` AS Sub_Category,
    Segment,
    ROUND(SUM(TotalSales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(TotalSales) * 100, 2) AS Profit_Margin_Percent,
    ROUND(AVG(AOV), 2) AS Average_Order_Value,
    COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM clean_superstore_sales
WHERE Order_Date_Converted IS NOT NULL
GROUP BY 
    YEAR(Order_Date_Converted),
    MONTH(Order_Date_Converted),
    Region,
    Category,
    `Sub-Category`,
    Segment
ORDER BY Year, Month;

#Monthly Trend
SELECT 
    Year, 
    Month, 
    SUM(Total_Sales) AS Sales
FROM v_sales_summary
GROUP BY Year, Month
ORDER BY Year, Month;


#Total sales of a year

SELECT Year, ROUND(SUM(Total_Sales), 2) AS Yearly_Sales
FROM v_sales_summary
GROUP BY Year; 

#Top categories

SELECT Category, SUM(Total_Sales) AS Total_Sales
FROM v_sales_summary
GROUP BY Category
ORDER BY Total_Sales DESC;






