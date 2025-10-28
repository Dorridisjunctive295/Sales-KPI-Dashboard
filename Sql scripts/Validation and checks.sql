select * FROM clean_superstore_sales;
UPDATE clean_superstore_sales 
SET Order_Date_Converted = STR_TO_DATE(`Order Date`, '%m/%d/%Y');

ALTER TABLE clean_superstore_sales 
ADD COLUMN Order_Date_Converted DATE;

UPDATE clean_superstore_sales
SET Order_Date_Converted = STR_TO_DATE(`Order Date`, '%m/%d/%Y');

UPDATE clean_superstore_sales
SET Order_Date_Converted = CAST(`Order Date` AS DATE);

SELECT `Order Date` FROM clean_superstore_sales LIMIT 10;


ALTER TABLE clean_superstore_sales ADD COLUMN Order_Date_Converted_Clean DATE;

UPDATE clean_superstore_sales
SET Order_Date_Converted_Clean = CAST(`Order Date` AS DATE);

SELECT DISTINCT `Order Date`
FROM clean_superstore_sales
WHERE `Order Date` NOT LIKE '____-__-__%';


UPDATE clean_superstore_sales
SET `Order Date` = NULL
WHERE `Order Date` = '0';


UPDATE clean_superstore_sales
SET Order_Date_Converted = CAST(`Order Date` AS DATE)
WHERE `Order Date` IS NOT NULL;

SELECT `Order Date`, Order_Date_Converted
FROM clean_superstore_sales
LIMIT 10;


SELECT DISTINCT `Order Date`
FROM clean_superstore_sales
WHERE `Order Date` IS NOT NULL
AND `Order Date` NOT LIKE '____-__-__%';

