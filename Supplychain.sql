CREATE DATABASE SupplyChainDB;
USE SupplyChainDB;

-- Table Structure creation

CREATE TABLE Dim_Customer (
    Customer_ID VARCHAR(20) PRIMARY KEY,
    Customer_Region VARCHAR(50),
    Customer_Country VARCHAR(50),
    Customer_City VARCHAR(50),
    Customer_Segment VARCHAR(50)
);

CREATE TABLE Dim_Warehouse (
    Warehouse_ID VARCHAR(10) PRIMARY KEY,
    Warehouse_City VARCHAR(50),
    Warehouse_Country VARCHAR(50),
    Warehouse_Region VARCHAR(50),
    Capacity_Units INT
);

CREATE TABLE Dim_Supplier (
    Supplier_ID VARCHAR(10) PRIMARY KEY,
    Supplier_Name VARCHAR(100),
    Supplier_Country VARCHAR(50),
    Supplier_City VARCHAR(50),
    Supplier_Tier VARCHAR(10),
    Reliability_Score DECIMAL(5,2)
);

CREATE TABLE Dim_Product (
    Product_ID VARCHAR(20) PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Unit_Cost DECIMAL(10,2),
    Unit_Price DECIMAL(10,2),
    Primary_Supplier_ID VARCHAR(10)
);

CREATE TABLE Fact_Orders (
    Order_ID VARCHAR(20) PRIMARY KEY,
    Customer_ID VARCHAR(20),
    Product_ID VARCHAR(20),
    Supplier_ID VARCHAR(10),
    Warehouse_ID VARCHAR(10),
	Order_Date DATE,
    Ship_Date DATE,
    Promised_Delivery_Date DATE,
    Actual_Delivery_Date DATE,
    Ship_Mode VARCHAR(50),
    Carrier VARCHAR(50),
    Order_Quantity INT,
    Shipped_Quantity INT,
    Unit_Price DECIMAL(10,2),
    Unit_Cost DECIMAL(10,2),
	Revenue DECIMAL(12,2),
    COGS DECIMAL(12,2),
    Shipping_Cost DECIMAL(10,2),
	Processing_Days INT,
    Transit_Days INT,
    Delay_Days INT,
	Delivery_Status VARCHAR(50),
    Fill_Rate_Pct DECIMAL(5,2)
);

CREATE TABLE Fact_Inventory (
    Product_ID VARCHAR(20),
    Warehouse_ID VARCHAR(10),
    Snapshot_Date DATE,
	Stock_On_Hand INT,
    Reorder_Level INT,
    Safety_Stock INT,
	Units_Received INT,
    Units_Shipped INT,
	Days_Of_Supply DECIMAL(10,2),
    Stockout_Flag INT
);

-- Verify all the tables

Select count(*) from dim_customer;
Select count(*) from dim_product;
Select count(*) from dim_supplier;
Select count(*) from dim_warehouse;
Select count(*) from fact_inventory;
Select count(*) from fact_orders;


SELECT 'dim_customer' AS Table_Name, COUNT(*) AS Row_Count
FROM dim_customer
UNION ALL
SELECT 'dim_product', COUNT(*)
FROM dim_product
UNION ALL
SELECT 'dim_supplier', COUNT(*)
FROM dim_supplier
UNION ALL
SELECT 'dim_warehouse', COUNT(*)
FROM dim_warehouse
UNION ALL
SELECT 'fact_inventory', COUNT(*)
FROM fact_inventory
UNION ALL
SELECT 'fact_orders', COUNT(*)
FROM fact_orders;

-- 1. TOTAL REVENUE
SELECT SUM(Revenue) AS Total_Revenue FROM Fact_Orders;

-- 2. GROSS MARGIN %
SELECT 
(SUM(Revenue) - SUM(COGS)) / SUM(Revenue) * 100 AS Gross_Margin
FROM Fact_Orders;

-- 3. ON-TIME DELIVERY %
SELECT 
COUNT(CASE WHEN Delivery_Status = 'On-Time' THEN 1 END) * 100.0 / COUNT(*) AS OTD
FROM Fact_Orders;

-- 4. FILL RATE %
SELECT 
SUM(Shipped_Quantity) * 100.0 / SUM(Order_Quantity) AS Fill_Rate
FROM Fact_Orders;

-- 5. PERFECT ORDER RATE
SELECT 
COUNT(CASE WHEN Delivery_Status='On-Time' AND Fill_Rate_Pct=100 THEN 1 END) 
* 100.0 / COUNT(*) AS Perfect_Order_Rate
FROM Fact_Orders;

-- 6. AVG DELAY
SELECT AVG(Delay_Days) AS Avg_Delay
FROM Fact_Orders WHERE Delay_Days > 0;

-- 7. INVENTORY TURNOVER
SELECT 
SUM(Units_Shipped) / AVG(Stock_On_Hand) AS Inventory_Turnover
FROM Fact_Inventory;

-- 8. STOCKOUT RATE
SELECT 
SUM(Stockout_Flag) * 100.0 / COUNT(*) AS Stockout_Rate
FROM Fact_Inventory;

-- 9. SUPPLIER RELIABILITY
SELECT 
S.Supplier_Name,
COUNT(CASE WHEN F.Delivery_Status='On-Time' THEN 1 END) * 100.0 / COUNT(*) AS Reliability
FROM Fact_Orders F
JOIN Dim_Supplier S ON F.Supplier_ID = S.Supplier_ID
GROUP BY S.Supplier_Name;

-- 10. REVENUE BY REGION
SELECT 
    dc.Customer_Region,
    ROUND(SUM(fo.Revenue), 2) AS KPI_Revenue_Region
FROM Fact_Orders fo
JOIN Dim_Customer dc
    ON fo.Customer_ID = dc.Customer_ID
GROUP BY dc.Customer_Region
ORDER BY KPI_Revenue_Region DESC;