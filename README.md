# 🚚 Supply Chain Analytics Dashboard

![Project Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![Tools](https://img.shields.io/badge/Tools-SQL%20%7C%20Power%20BI%20%7C%20Tableau-blue)
![Schema](https://img.shields.io/badge/Schema-Star%20Schema-purple)
![Domain](https://img.shields.io/badge/Domain-Supply%20Chain%20Analytics-orange)
![Database](https://img.shields.io/badge/Database-MySQL-yellowgreen)

> An end-to-end **Supply Chain Analytics Dashboard** built to analyze and monitor sales performance, inventory management, supplier reliability, warehouse utilization, and delivery efficiency — all in one centralized intelligence system.

---

## 📌 Table of Contents

- [Project Overview](#-project-overview)
- [Business Problem](#-business-problem)
- [Problems Found & How They Were Resolved](#-problems-found--how-they-were-resolved)
- [How This Project Helps Business](#-how-this-project-helps-business)
- [Tech Stack](#-tech-stack)
- [Data Model](#-data-model--star-schema)
- [Project Architecture](#-project-architecture)
- [Key KPIs Tracked](#-key-kpis-tracked)
- [SQL Analysis](#-sql-analysis)
- [Key Outcomes](#-key-outcomes)
- [Dashboard Previews](#-dashboard-previews)

---

## 🔍 Project Overview

This project builds a **complete supply chain intelligence system** using real-world style data across customers, suppliers, warehouses, products, orders, and inventory. The pipeline starts from raw CSV data, moves through structured SQL in MySQL, and delivers insights via interactive dashboards in Power BI and Tableau.

**Data Pipeline:**

Raw CSV Data → MySQL (Schema + KPI Queries) → Power BI Dashboard → Tableau Dashboard → Business Insights

---

## 🎯 Business Problem

Modern supply chain teams face a critical challenge — **data is scattered across multiple systems** with no single source of truth. This leads to:

- ❌ No visibility into real-time delivery performance
- ❌ Inability to identify which suppliers are causing delays
- ❌ Stock imbalances — overstocking in some warehouses, stockouts in others
- ❌ Revenue leakage due to unfulfilled or delayed orders
- ❌ No way to measure supplier reliability objectively
- ❌ Slow, manual reporting that takes days instead of minutes

**This project solves all of the above** by centralizing data into a Star Schema and building KPI dashboards that give instant, actionable visibility.

---

## 🔎 Problems Found & How They Were Resolved

| # | Problem Identified | Root Cause | Resolution Applied |
|---|---|---|---|
| 1 | **High Delivery Delays** | Suppliers missing promised delivery dates | Tracked `Delay_Days` per supplier; built Supplier Reliability KPI to flag underperformers |
| 2 | **Low Fill Rate on Orders** | Insufficient stock at warehouse level | Measured `Fill_Rate_Pct` = Shipped/Ordered; linked to inventory snapshot data |
| 3 | **Stockout Incidents** | No early warning system for low stock | Added `Stockout_Flag` in `Fact_Inventory`; built Stockout Rate KPI to trigger reorder alerts |
| 4 | **Uneven Revenue by Region** | No regional breakdown existed | Built Revenue by Region query joining `Fact_Orders` + `Dim_Customer`; visualized in Tableau map |
| 5 | **No Supplier Accountability** | Supplier performance was never measured | Created Supplier Reliability Score using On-Time Delivery % grouped by supplier |
| 6 | **Gross Margin Erosion** | High COGS not visible against revenue | Built Gross Margin % KPI = `(Revenue - COGS) / Revenue * 100` |
| 7 | **Inventory Turnover Unknown** | Stock movement was never tracked | Calculated `Units_Shipped / AVG(Stock_On_Hand)` to measure how efficiently stock moves |
| 8 | **Perfect Order Rate Not Tracked** | No combined delivery + fill metric | Built Perfect Order Rate: orders that are both On-Time AND have 100% Fill Rate |

---

## 💼 How This Project Helps Business

### 1. 💰 Revenue Optimization
By tracking **Revenue by Region** and **Gross Margin %**, business leaders can identify which markets are most profitable and redirect resources accordingly. Revenue leakage from delayed or unfulfilled orders becomes immediately visible.

### 2. 🚛 Delivery Performance Improvement
The **On-Time Delivery %** and **Average Delay Days** KPIs give operations teams a real-time pulse on logistics performance. Carriers and routes causing delays can be identified and replaced, directly improving customer satisfaction.

### 3. 🤝 Supplier Risk Management
The **Supplier Reliability Score** ranks every supplier by their on-time delivery rate. Procurement teams can use this to renegotiate contracts, diversify supply sources, or eliminate consistently underperforming suppliers before they impact the business.

### 4. 📦 Smarter Inventory Management
**Stockout Rate** and **Inventory Turnover** metrics help warehouse managers maintain the right stock levels — avoiding both costly overstocking and revenue-losing stockouts. The `Reorder_Level` and `Safety_Stock` fields enable proactive replenishment.

### 5. ⭐ Perfect Order Rate as a Customer Experience KPI
The **Perfect Order Rate** — orders that are on-time AND fully fulfilled — directly correlates with customer retention. Improving this metric reduces complaints, returns, and churn.

### 6. 📊 Data-Driven Decision Making
Before this project, decisions were based on gut feeling and manual spreadsheets. Now every KPI is backed by SQL-verified data, visualized in real time, and accessible to any stakeholder through Power BI or Tableau dashboards.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| 🗄️ **MySQL** | Database design, Star Schema creation, all KPI queries |
| 📈 **Power BI** | Interactive executive dashboard, DAX measures, slicers |
| 📉 **Tableau** | Visual analytics, geographic analysis, storytelling |

---

## 📐 Data Model — Star Schema

4 Dimension Tables: Dim_Customer | Dim_Warehouse | Dim_Supplier | Dim_Product

2 Fact Tables: Fact_Orders | Fact_Inventory

```
                    ┌─────────────────┐
                    │   Dim_Customer  │
                    │  Customer_ID PK │
                    └────────┬────────┘
                             │
┌──────────────┐    ┌────────▼────────┐    ┌──────────────────┐
│ Dim_Supplier │    │   Fact_Orders   │    │  Dim_Warehouse   │
│Supplier_ID PK├────┤  Order_ID PK    ├────┤ Warehouse_ID PK  │
└──────────────┘    │  Customer_ID FK │    └──────────────────┘
                    │  Product_ID FK  │
┌──────────────┐    │  Supplier_ID FK │    ┌──────────────────┐
│  Dim_Product │    │  Warehouse_ID FK│    │  Fact_Inventory  │
│ Product_ID PK├────┤  Revenue        ├────┤  Product_ID FK   │
└──────────────┘    │  COGS           │    │  Warehouse_ID FK │
                    │  Delivery_Status│    │  Stockout_Flag   │
                    └─────────────────┘    └──────────────────┘
```

### Dimension Tables

| Table | Key Fields |
|-------|-----------|
| 🧑 Dim_Customer | Customer_ID, Region, Country, City, Segment |
| 🏭 Dim_Warehouse | Warehouse_ID, City, Country, Region, Capacity_Units |
| 🤝 Dim_Supplier | Supplier_ID, Name, Country, Tier, Reliability_Score |
| 📦 Dim_Product | Product_ID, Name, Category, Unit_Cost, Unit_Price |

### Fact Tables

| Table | Key Fields |
|-------|-----------|
| 📋 Fact_Orders | Order_ID, Revenue, COGS, Delay_Days, Delivery_Status, Fill_Rate_Pct |
| 📊 Fact_Inventory | Product_ID, Stock_On_Hand, Reorder_Level, Stockout_Flag |

---

## 📁 Project Architecture
📦 supply-chain-analytics-dashboard
┣ 📂 sql
┃ ┗ 📄 Supplychain.sql
┣ 📂 dashboards
┃ ┣ 📈 supply_chain_dash_power_bi.pbit
┃ ┗ 📉 tableau_supply_chain.twbx
┣ 📂 images
┃ ┣ 🖼 powerbi_dashboard.png
┃ ┗ 🖼 tableau_dashboard.png
┗ 📄 README.md
---

## 📊 Key KPIs Tracked

| KPI | Formula | Business Value |
|-----|---------|----------------|
| 💰 Total Revenue | SUM(Revenue) | Overall business performance |
| 📈 Gross Margin % | (Revenue - COGS) / Revenue × 100 | Profitability health check |
| 🚛 On-Time Delivery % | On-Time Orders / Total Orders × 100 | Customer satisfaction driver |
| 📦 Fill Rate % | Shipped Qty / Ordered Qty × 100 | Order fulfillment efficiency |
| ⭐ Perfect Order Rate | On-Time AND Fill Rate = 100% | Combined excellence metric |
| ⏰ Average Delay Days | AVG(Delay_Days) where Delay > 0 | Logistics bottleneck indicator |
| 🔄 Inventory Turnover | Units Shipped / AVG(Stock On Hand) | Stock movement efficiency |
| ⚠️ Stockout Rate | Stockout Flags / Total Records × 100 | Supply risk indicator |
| 🤝 Supplier Reliability | On-Time % grouped by Supplier | Vendor accountability score |
| 🌍 Revenue by Region | SUM(Revenue) grouped by Region | Geographic performance map |

---

## 🗄️ SQL Analysis

> **Database:** SupplyChainDB | **Tool:** MySQL Workbench | **Design:** Star Schema

<details>
<summary>📋 Click to expand — Full SQL Queries</summary>

### 1. 💰 Total Revenue
```sql
SELECT SUM(Revenue) AS Total_Revenue 
FROM Fact_Orders;
```

### 2. 📈 Gross Margin %
```sql
SELECT 
    (SUM(Revenue) - SUM(COGS)) / SUM(Revenue) * 100 AS Gross_Margin
FROM Fact_Orders;
```

### 3. 🚛 On-Time Delivery %
```sql
SELECT 
    COUNT(CASE WHEN Delivery_Status = 'On-Time' THEN 1 END) * 100.0 / COUNT(*) AS OTD
FROM Fact_Orders;
```

### 4. 📦 Fill Rate %
```sql
SELECT 
    SUM(Shipped_Quantity) * 100.0 / SUM(Order_Quantity) AS Fill_Rate
FROM Fact_Orders;
```

### 5. ⭐ Perfect Order Rate
```sql
SELECT 
    COUNT(CASE WHEN Delivery_Status = 'On-Time' AND Fill_Rate_Pct = 100 THEN 1 END) 
    * 100.0 / COUNT(*) AS Perfect_Order_Rate
FROM Fact_Orders;
```

### 6. ⏰ Average Delay Days
```sql
SELECT AVG(Delay_Days) AS Avg_Delay
FROM Fact_Orders 
WHERE Delay_Days > 0;
```

### 7. 🔄 Inventory Turnover
```sql
SELECT 
    SUM(Units_Shipped) / AVG(Stock_On_Hand) AS Inventory_Turnover
FROM Fact_Inventory;
```

### 8. ⚠️ Stockout Rate
```sql
SELECT 
    SUM(Stockout_Flag) * 100.0 / COUNT(*) AS Stockout_Rate
FROM Fact_Inventory;
```

### 9. 🤝 Supplier Reliability
```sql
SELECT 
    S.Supplier_Name,
    COUNT(CASE WHEN F.Delivery_Status = 'On-Time' THEN 1 END) * 100.0 / COUNT(*) AS Reliability
FROM Fact_Orders F
JOIN Dim_Supplier S ON F.Supplier_ID = S.Supplier_ID
GROUP BY S.Supplier_Name;
```

### 10. 🌍 Revenue by Region
```sql
SELECT 
    dc.Customer_Region,
    ROUND(SUM(fo.Revenue), 2) AS KPI_Revenue_Region
FROM Fact_Orders fo
JOIN Dim_Customer dc ON fo.Customer_ID = dc.Customer_ID
GROUP BY dc.Customer_Region
ORDER BY KPI_Revenue_Region DESC;
```

</details>

---

## 🔍 SQL Concepts Used

| Concept | Applied In |
|---------|-----------|
| ✅ CREATE DATABASE & TABLE | Full Star Schema Setup |
| ✅ PRIMARY KEY & FOREIGN KEY | Relational Data Integrity |
| ✅ INNER JOIN | Supplier & Customer Analysis |
| ✅ GROUP BY & ORDER BY | Regional & Supplier Reports |
| ✅ CASE WHEN | Delivery Status & Order Classification |
| ✅ UNION ALL | Table Row Count Verification |
| ✅ Aggregate Functions | SUM, AVG, COUNT across all KPIs |
| ✅ DECIMAL & VARCHAR | Precise Data Type Management |
| ✅ Star Schema Design | 4 Dimension + 2 Fact Tables |

---

## 🏆 Key Outcomes

| Metric | Result |
|--------|--------|
| 🗄️ Tables Designed | 6 (4 Dimension + 2 Fact) |
| 📊 KPIs Built | 10 Business-Critical KPIs |
| 🚛 Delivery Performance Tracked | On-Time %, Avg Delay, Perfect Order Rate |
| 📦 Inventory Health Monitored | Turnover Rate + Stockout Rate |
| 🤝 Supplier Accountability | Individual Reliability Score per Supplier |
| 🌍 Geographic Coverage | Revenue mapped across all customer regions |

---

## 📸 Dashboard Previews

### 📈 Power BI Dashboard
> Executive-level KPI reporting with dynamic slicers for region, supplier, product category, and time period.

![Power BI Dashboard](https://raw.githubusercontent.com/amansume26-stack/supply-chain-analytics-dashboard/main/Snapshot%20of%20Power%20BI%20Dashboard.png)

---

### 📉 Tableau Dashboard
> Geographic revenue mapping, supplier performance ranking, and delivery trend analysis.

![Tableau Dashboard](https://raw.githubusercontent.com/amansume26-stack/supply-chain-analytics-dashboard/main/Snapshot%20of%20Tableau%20Dashboard.png)

---

## 📬 How to Use This Repository

1. **SQL** — Open `Supplychain.sql` in MySQL Workbench, run schema setup first, then load your CSV data, then run KPI queries
2. **Power BI** — Open `supply_chain_dash_power_bi.pbit` in Power BI Desktop
3. **Tableau** — Open `tableau_supply_chain.twbx` in Tableau Desktop

---

> *"Without data, you're just another person with an opinion."* — W. Edwards Deming
>
> 📊 Supply Chain Analytics | End-to-End Data Analytics Project | MySQL • Power BI • Tableau

 
