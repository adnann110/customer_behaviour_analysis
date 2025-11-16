📊 Customer Shopping Behavior – Data Analytics Project
End-to-End Data Analytics | SQL | Python | MySQL | Power BI
📁 Project Overview

This project analyzes customer shopping behavior using a large dataset containing demographic information, purchase patterns, product preferences, review ratings, subscription details, and more.

The goal is to extract meaningful insights that help businesses:

✔ Understand customer buying patterns
✔ Identify high-value customers
✔ Analyze revenue trends
✔ Improve marketing strategies
✔ Optimize product and category performance
✔ Measure the impact of discounts and promotions

This project includes data cleaning, SQL analysis, MySQL database integration, and a Power BI interactive dashboard.

📂 Dataset Description

The dataset contains the following fields:

Customer ID

Age

Gender

Item Purchased

Category

Purchase Amount (USD)

Location

Size

Color

Season

Review Rating

Subscription Status

Shipping Type

Discount Applied

Promo Code Used

Previous Purchases

Payment Method

Frequency of Purchases

This provides a 360-degree view of customer behavior.

🛠 Technologies Used

Python (Pandas, SQLAlchemy)

MySQL Database

SQL Queries

Power BI Desktop

DAX Measures

Data Cleaning & Transformation

🗄 Database Setup

The dataset was uploaded into MySQL using Python:

from sqlalchemy import create_engine
from urllib.parse import quote_plus
import pandas as pd

password = quote_plus("YOUR_PASSWORD")
engine = create_engine(f"mysql+pymysql://root:{password}@127.0.0.1:3306/customer_behaviour")

df = pd.read_csv("customer_shopping_behavior.csv")
df.to_sql("customer", engine, index=False, if_exists="replace")

🧠 SQL Analysis Performed
1. Total Revenue
SELECT SUM(`Purchase Amount (USD)`) AS total_revenue
FROM customer;

2. Revenue by Gender
SELECT Gender, SUM(`Purchase Amount (USD)`) AS revenue
FROM customer
GROUP BY Gender;

3. Top 5 Items by Rating
SELECT `Item Purchased`,
       ROUND(AVG(`Review Rating`),2) AS avg_rating
FROM customer
GROUP BY `Item Purchased`
ORDER BY avg_rating DESC
LIMIT 5;

4. Customer Segmentation (New, Returning, Loyal)
SELECT 
    CASE
        WHEN `Previous Purchases` = 1 THEN 'New'
        WHEN `Previous Purchases` BETWEEN 2 AND 10 THEN 'Returning'
        ELSE 'Loyal'
    END AS customer_segment,
    COUNT(*) AS total_customers
FROM customer
GROUP BY customer_segment;

5. Age Group Classification (Teen, Young Adult, Adult, Middle Age, Senior)
SELECT 
    CASE
        WHEN `Age` < 18 THEN 'Teen'
        WHEN `Age` BETWEEN 18 AND 29 THEN 'Young Adult'
        WHEN `Age` BETWEEN 30 AND 45 THEN 'Adult'
        WHEN `Age` BETWEEN 46 AND 60 THEN 'Middle Age'
        ELSE 'Senior'
    END AS age_group,
    SUM(`Purchase Amount (USD)`) AS total_revenue
FROM customer
GROUP BY age_group
ORDER BY total_revenue DESC;

📊 Power BI Dashboard

The Power BI dashboard includes:

✔ KPIs

Total Customers

Total Revenue

Average Spend

Discount Usage Rate

Average Review Rating

✔ Visuals

Revenue by Category

Purchases by Gender

Customer Segmentation (New / Returning / Loyal)

Age-group revenue chart

Top products by demand

Discount vs Revenue comparison

Shipping preference analysis

✔ DAX Measures Example

Total Customers

Total Customers = COUNT('customer'[Customer ID])


Total Revenue

Total Revenue = SUM('customer'[Purchase Amount (USD)])


Average Rating

Average Rating = AVERAGE('customer'[Review Rating])

📈 Key Insights

Young Adults & Adults generate the highest revenue.

Returning customers contribute significantly to overall sales.

Discounts increase purchase frequency but lower average rating slightly.

Express shipping is preferred for high-value orders.

Clothing and accessories have the highest repeat purchases.

🚀 Conclusion

This project demonstrates an end-to-end data analytics workflow using:

Clean data ingestion

SQL transformation

Advanced business queries

Interactive Power BI dashboard

Actionable business insights

It can be extended with:

Machine learning (customer segmentation, churn prediction)

Forecasting (sales prediction)

Recommendation systems
