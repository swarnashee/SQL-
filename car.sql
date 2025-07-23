CREATE DATABASE CarSalesDB;
USE CarSalesDB;

CREATE USER 'powerbi_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Power@1234';

GRANT ALL PRIVILEGES ON *.* TO 'powerbi_user'@'localhost';
FLUSH PRIVILEGES;

create table car_sales (
Brand	text,
Model text ,
`Year` text ,
Price double,
    Mileage int,
	Color text,
	`Condition`	text,
    First_Name	text,
    Last_Name text,
    Address varchar(100),
	Country text,
    `Full Name` text
    );
    
    SET GLOBAL LOCAL_INFILE=ON;
LOAD DATA LOCAL INFILE 'C:/Users/User/Downloads/car/car_sales_dataset_with_person_details.csv'
INTO TABLE car_sales
fields TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
ignore 1 lines;
select * from  car_sales;

set sql_safe_updates = 0;

UPDATE car_sales
SET Year = CAST(Year AS UNSIGNED);

SELECT 
  CAST(CONCAT(Year, '-01-01') AS DATE) AS Year_As_Date
FROM car_sales;

ALTER TABLE car_sales ADD YearDate DATE;

set sql_safe_updates = 0;
UPDATE car_sales
SET YearDate = 
  CASE 
    WHEN Year REGEXP '^[0-9]{4}$' 
    THEN CAST(CONCAT(Year, '-01-01') AS DATE)
    ELSE NULL
  END;
  
  select * from  car_sales;
  
  SELECT 
  YEAR(YearDate) AS Year_Only
FROM car_sales;

ALTER TABLE car_sales ADD Year_Only INT;

UPDATE car_sales
SET Year_Only = YEAR(Year_Date);

/*   power bi visualization */

/*TOTAL CARS SHOWS BY BRAND--BAR CHART*/
SELECT Brand, COUNT(*) AS Cars_Sold
FROM car_sales
GROUP BY Brand
ORDER BY Cars_Sold DESC;

/*AVERAGE PRICE BY BRAND -- BAR OR COLUMN*/
SELECT Brand, AVG(Price) AS Average_Price
FROM car_sales
GROUP BY Brand
ORDER BY Average_Price DESC;

/* TOTAL REVENUE BY COUNTRY-- MAP VISUAL,DONUT CHART*/
SELECT Country, SUM(Price) AS Total_Revenue
FROM car_sales
GROUP BY Country
ORDER BY Total_Revenue DESC;

/*CAR CONDITION BREAK DOWN PIE, DONU CHART*/
SELECT `Condition`, COUNT(*) AS Number_Of_Cars
FROM car_sales
GROUP BY `Condition`;

/*TOTAL 5 MOST EXPENSIVE CAR TABLE,CARD VISUAL*/
SELECT Brand, Model, Price
FROM car_sales
ORDER BY Price DESC
LIMIT 5;

/*MILEAGE RANGE BUCKETS--BAR,COLUMN CHART*/
SELECT 
  CASE 
    WHEN Mileage < 10000 THEN 'Under 10K'
    WHEN Mileage BETWEEN 10000 AND 50000 THEN '10K - 50K'
    WHEN Mileage BETWEEN 50001 AND 100000 THEN '50K - 100K'
    ELSE '100K+'
  END AS Mileage_Range,
  COUNT(*) AS Car_Count
FROM car_sales
GROUP BY Mileage_Range;

/*YEARWISE CAR SALES -- LINE CHART */
SELECT YEAR(YearDate) AS Sale_Year, COUNT(*) AS Cars_Sold
FROM car_sales
GROUP BY Sale_Year
ORDER BY Sale_Year;

/*BRAND+CONDITION MATRIX - MATRIX VISUALS*/
SELECT Brand, `Condition`, COUNT(*) AS Count
FROM car_sales
GROUP BY Brand, `Condition`;

/* COLOUR POPULARITY --BAR */
SELECT Color, COUNT(*) AS Count
FROM car_sales
GROUP BY Color
ORDER BY Count DESC;

/* CUSTOM SPEND SUMMERY*/
SELECT `Full Name`, SUM(Price) AS Total_Spent
FROM car_sales
GROUP BY `Full Name`
ORDER BY Total_Spent DESC;


/*FOR KPI */

/*TOTAL REVENUE -- CARD VISUAL*/
SELECT SUM(Price) AS Total_Revenue
FROM car_sales;

/*TOTAL CARS SOLD -- CARD-NO OF CAR SOLD*/
SELECT COUNT(*) AS Total_Cars_Sold
FROM car_sales;

/* AVERAGE CAR PRICE  --CARD VISUAL*/
SELECT ROUND(AVG(Price), 2) AS Average_Price
FROM car_sales;

/*TOTAL UNIQUE CUSTOMER-- CARD VISUAL , CUSTOMER COUNT*/
SELECT COUNT(DISTINCT `Full Name`) AS Unique_Customers
FROM car_sales;

/*MOST SOLD BRAND -- CARD--TOP BRAND*/
SELECT Brand, COUNT(*) AS Brand_Sales
FROM car_sales
GROUP BY Brand
ORDER BY Brand_Sales DESC
LIMIT 1;

/* NEW AS USED CAR COUNT  -- 2CARD, STACKED BAR*/
SELECT 
  SUM(CASE WHEN `Condition` = 'New' THEN 1 ELSE 0 END) AS New_Cars,
  SUM(CASE WHEN `Condition` = 'Used' THEN 1 ELSE 0 END) AS Used_Cars
FROM car_sales;

/*HIGHEST SALES(MAX PRICE CAR)--CARD FOR PRICE*/
SELECT Brand, Model, Price
FROM car_sales
ORDER BY Price DESC
LIMIT 1;

/*LOWEST MILEAGE CAR--TABLE VISUAL OR CARD FOR MILEAGE*/
SELECT Brand, Model, Mileage
FROM car_sales
WHERE Mileage IS NOT NULL
ORDER BY Mileage ASC
LIMIT 1;

/*MOST ACTIVITY COUNTRY-- CARD ,TOP COUNTRY*/
SELECT Country, COUNT(*) AS Cars_Sold
FROM car_sales
GROUP BY Country
ORDER BY Cars_Sold DESC
LIMIT 1;
