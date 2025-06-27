# Data Analysis
# 📊 Stock Price Data Analysis Using SQL

This project demonstrates practical SQL skills by analyzing historical stock price data. The goal is to showcase data querying, transformation, trend detection, and performance insights — ideal for building a job-ready portfolio.

## 📁 Dataset Overview

The dataset consists of daily historical stock prices with the following fields:

| Column     | Description                   |
|------------|-------------------------------|
| `date`     | Date of the record            |
| `year`     | Extracted year                |
| `month`    | Extracted month               |
| `open`     | Stock price at market open    |
| `high`     | Highest price of the day      |
| `low`      | Lowest price of the day       |
| `close`    | Stock price at market close   |
| `volume`   | Number of shares traded       |
| `id`       | Unique row ID                 |

## ✅ Key Questions Explored with SQL

### 📈 Stock Price Analysis
- What was the highest closing price each year?
- Which day had the highest trading volume?
- Calculate the daily price change (`high - low`) and find the day with the largest swing.
- Find the average closing price for each month of each year.
- Which month had the highest average trading volume?

### 📊 Trend Detection
- Identify consecutive days where the closing price decreased.
- What is the moving average of closing price over the last 5 days (for each row)?
- List all days where the closing price was higher than the opening price.

### 📉 Volatility and Performance
- Which year was most volatile (based on average daily swing)?
- Calculate month-over-month % change in average closing price.

## 🧠 What You'll Learn

- Writing SQL queries to answer real-world business questions  
- Using window functions like `LAG()`, `LEAD()`, `AVG() OVER`  
- Identifying patterns and trends in financial datasets  
- Grouping, filtering, and ranking with advanced SQL  

---

## 📌 How to Use

1. Clone the repo  
2. Load the dataset into your preferred SQL environment  
3. Run the queries in `/sql/` or Jupyter notebooks  
4. Modify or extend the analysis for your own projects

---

## 💼 Ideal For

- Data Analysts / BI Developers preparing for interviews  
- Portfolio builders looking to showcase SQL expertise  
- Anyone learning real-world data transformation using SQL

---

## 📬 Contact
If you liked this project, feel free to fork and star the repo ⭐!

