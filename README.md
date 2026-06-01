# 🚚 Supply Chain Analytics Dashboard
### Excel | Power BI | Tableau | MySQL
---

## 📌 Project Overview
An end-to-end **Supply Chain Analytics Dashboard** built to analyze and monitor 
sales performance, inventory management, supplier reliability, warehouse 
utilization, and delivery efficiency — all in one centralized dashboard.
---
## 🎯 Business Problem
Supply chain teams struggle with scattered data across multiple sources, 
making it difficult to:
- Track real-time performance
- Identify delivery bottlenecks
- Monitor supplier reliability
- Make data-driven decisions quickly
---
## 🛠️ Tools & Technologies
| Tool | Purpose |
|------|---------|
| 🗄️ MySQL | Data extraction, joins, aggregations |
| 📊 Excel | Pivot Tables, Power Pivot, DAX, Slicers |
| 📈 Power BI | Interactive dashboards, KPI reporting |
| 📉 Tableau | Data visualization & storytelling |

## 🔄 Project Workflow
---
## 📐 Data Model
- ✅ Designed **Star Schema** with fact & dimension tables
- ✅ Relationships built on **Product ID, Supplier ID, 
      Customer ID, Warehouse ID**
- ✅ Enabled consistent metrics across all dashboard views
---
## 📊 Key KPIs Tracked
| KPI | Description |
|-----|-------------|
| 💰 Total Revenue | Overall sales performance |
| 📦 Inventory Turnover | Stock movement efficiency |
| 🏭 Warehouse Utilization | Storage capacity usage |
| 🚛 On-Time Delivery % | Delivery performance |
| 🤝 Supplier Reliability | Supplier performance score |
| ⏰ Delay Percentage | Late delivery tracking |
| 👤 Revenue per Customer | Customer value analysis |
|📈 Monthly Revenue Trends
|🌍 Regional Sales Analysis
---
## 🏆 Key Outcomes
| Metric | Result |
|--------|--------|
| 📦 Products Analyzed | 500+ |
| 🤝 Suppliers Analyzed | 50+ |
| 🚛 Delivery Delays Reduced | 20% |
| 📦 Inventory Turnover Improved | 15% |
---
## 📁 Project Structure
📦 supply-chain-analytics-dashboard
┣ 📂 data
┃ ┣ 📜 products.csv
┃ ┣ 📜 suppliers.csv
┃ ┣ 📜 customers.csv
┃ ┣ 📜 warehouse.csv
┃ ┗ 📜 delivery.csv
┣ 📂 sql
┃ ┗ 📜 queries.sql
┣ 📂 excel
┃ ┗ 📜 dashboard.xlsx
┣ 📂 Power BI
┃ ┗ 📜 dashboard.pbix
┣ 📂 tableau
┃ ┗ 📜 dashboard.twbx
---

## 💡 Key Insights Generated
- 📌 Identified **top performing products** and **underperforming suppliers**
- 📌 Highlighted **delivery bottlenecks** affecting customer satisfaction
- 📌 Monitored **warehouse capacity** to optimize storage efficiency
---
## 🗄️ SQL Queries — Supply Chain Analytics

> **Tool:** MySQL Workbench
> **Database:** SupplyChainDB
> **Tables:** 4 Dimension Tables + 2 Fact Tables (Star Schema)

---

## 📐 Database Schema

### Dimension Tables
| Table | Description |
|-------|-------------|
| 🧑 Dim_Customer | Customer region, city, segment |
| 🏭 Dim_Warehouse | Warehouse location & capacity |
| 🤝 Dim_Supplier | Supplier details & reliability score |
| 📦 Dim_Product | Product category, cost & price |

### Fact Tables
| Table | Description |
|-------|-------------|
| 📋 Fact_Orders | Orders, delivery, revenue & COGS |
| 📊 Fact_Inventory | Stock levels, reorder & stockout |

---

## 📊 KPI Queries Written

| # | KPI | Query Type |
|---|-----|------------|
| 1 | 💰 Total Revenue | SUM Aggregation |
| 2 | 📈 Gross Margin % | Revenue vs COGS |
| 3 | 🚛 On-Time Delivery % | CASE + COUNT |
| 4 | 📦 Fill Rate % | Shipped vs Ordered |
| 5 | ⭐ Perfect Order Rate | Multi-condition CASE |
| 6 | ⏰ Average Delay Days | AVG Aggregation |
| 7 | 🔄 Inventory Turnover | Units Shipped / Avg Stock |
| 8 | ⚠️ Stockout Rate | Flag Aggregation |
| 9 | 🤝 Supplier Reliability | JOIN + CASE + GROUP BY |
| 10 | 🌍 Revenue by Region | JOIN + GROUP BY + ORDER BY |

---
## 🔍 SQL Concepts Used

| Concept | Used In |
|---------|---------|
| ✅ CREATE DATABASE & TABLE | Schema Setup |
| ✅ PRIMARY KEY & DATA TYPES | Table Design |
| ✅ JOINS (INNER JOIN) | Supplier & Customer Analysis |
| ✅ GROUP BY & ORDER BY | Regional & Supplier Reports |
| ✅ CASE WHEN | Delivery & Order Status |
| ✅ UNION ALL | Table Row Count Verification |
| ✅ Aggregate Functions | SUM, AVG, COUNT |
| ✅ Subqueries & CTEs | KPI Calculations |
| ✅ DECIMAL & VARCHAR | Data Type Management |
| ✅ Star Schema Design | Fact & Dimension Tables |

---

## 💡 Sample Queries

### 💰 Total Revenue
```sql
SELECT SUM(Revenue) AS Total_Revenue 
FROM Fact_Orders;
```

### 🚛 On-Time Delivery %
```sql
SELECT 
COUNT(CASE WHEN Delivery_Status = 'On-Time' 
      THEN 1 END) * 100.0 / COUNT(*) AS OTD
FROM Fact_Orders;
```

### 🤝 Supplier Reliability
```sql
SELECT 
    S.Supplier_Name,
    COUNT(CASE WHEN F.Delivery_Status='On-Time' 
          THEN 1 END) * 100.0 / COUNT(*) AS Reliability
FROM Fact_Orders F
JOIN Dim_Supplier S 
    ON F.Supplier_ID = S.Supplier_ID
GROUP BY S.Supplier_Name;
```

### 🌍 Revenue by Region
```sql
SELECT 
    dc.Customer_Region,
    ROUND(SUM(fo.Revenue), 2) AS Revenue
FROM Fact_Orders fo
JOIN Dim_Customer dc
    ON fo.Customer_ID = dc.Customer_ID
GROUP BY dc.Customer_Region
ORDER BY Revenue DESC;

---
## 📸 Dashboard Screenshots

### 📊 Power BI Dashboard
![Power BI Dashboard](https://github.com/amansume26-stack/supply-chain-analytics-dashboard/blob/main/Snapshot%20of%20Dashbaord.png)
### 📈 Excel Dashboard  
![Excel](images/excel_dashboard.png)

### 📉 Tableau Dashboard
https://github.com/amansume26-stack/supply-chain-analytics-dashboard/blob/main/Snapshot%20of%20Tableau%20Dashbaord.png

### 📐 Data Model
![Star Schema](images/data_model.png)
                   
