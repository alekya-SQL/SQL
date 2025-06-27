--What was the highest closing price each year?

SELECT YEAR,
       max(CLOSE)
FROM tutorial.aapl_historical_stock_price
GROUP BY YEAR
ORDER BY YEAR

--Which day had the highest trading volume?

SELECT date,volume
FROM tutorial.aapl_historical_stock_price
WHERE volume IN
    (SELECT max(volume)
     FROM tutorial.aapl_historical_stock_price )

--Calculate the daily price change (high - low) and find the day with the largest swing.

  SELECT Top 1 id,date,high - low AS HighLow
  FROM tutorial.aapl_historical_stock_price WHERE YEAR = 2014
ORDER BY high - low


--Find the average closing price for each month of each year.

SELECT YEAR,
       MONTH,
       avg(CLOSE)
FROM tutorial.aapl_historical_stock_price
WHERE YEAR >=2013
GROUP BY YEAR,
         MONTH
ORDER BY YEAR,
         MONTH 

--Which month had the highest average trading volume?

SELECT TOP 1 YEAR,
       MONTH,
       avg(CLOSE)
FROM tutorial.aapl_historical_stock_price
GROUP BY YEAR,
         MONTH
ORDER BY avg(CLOSE)


--the top 5 months by average volume ?

SELECT TOP 5 YEAR,
       MONTH,
       avg(CLOSE)
FROM tutorial.aapl_historical_stock_price
GROUP BY YEAR,
         MONTH
ORDER BY avg(CLOSE)


--alternative solution using window functions
WITH avg_volume_per_month AS
  (SELECT YEAR,
          MONTH,
          ROUND(AVG(volume)) AS avg_volume
   FROM tutorial.aapl_historical_stock_price
   GROUP BY YEAR,
            MONTH),
     ranked_months AS
  (SELECT *,
          RANK() OVER (
                       ORDER BY avg_volume DESC) AS rank
   FROM avg_volume_per_month)
SELECT YEAR,
       MONTH,
       avg_volume
FROM ranked_months
WHERE rank <= 5
ORDER BY avg_volume DESC;

--Identify consecutive days where the closing price decreased.
 

WITH CTE AS
  (SELECT Prevdate,date
   FROM
     (SELECT lag(date) over(
                            ORDER BY date ASC) AS prevdate,date, lag(flag) over(
                                                                                ORDER BY date ASC) AS prevflag,
                                                                 flag
      FROM
        (SELECT date, CLOSE,
                      CASE
                          WHEN CLOSE < prevclose THEN 'decreased'
                          ELSE 'Increased'
                      END AS flag
         FROM
           (SELECT date, CLOSE,
                         lag(CLOSE) over(
                                         ORDER BY date) AS prevclose
            FROM tutorial.aapl_historical_stock_price
            WHERE YEAR >= 2014) a) b)c
   WHERE prevflag = 'decreased'
     AND flag ='decreased')
SELECT prevdate
FROM CTE
UNION
SELECT Date
FROM CTE 

--What is the moving average of closing price over the last 5 days (for each row)?

SELECT date, CLOSE,
             AVG(CLOSE) OVER (
                              ORDER BY date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS moving_avg_5day
FROM tutorial.aapl_historical_stock_price
WHERE YEAR >= 2014
ORDER BY date 

--List all days where closing price was higher than opening price.

SELECT date,OPEN,
            CLOSE
FROM tutorial.aapl_historical_stock_price
WHERE CLOSE > OPEN
ORDER BY date 
-- Which YEAR was most VOLATILE (based ON average daily swing)? WITH CTE AS
  (SELECT YEAR,
          AVG(high - low) AS avg_daily_swing
   FROM tutorial.aapl_historical_stock_price
   GROUP BY YEAR)
SELECT YEAR
FROM CTE
WHERE avg_daily_swing =
    (SELECT MAX(avg_daily_swing)
     FROM CTE);

--Calculate month-over-month % change in average closing price.
WITH MonthlyAvg AS (
    SELECT
        year AS yr,
        month AS mn,
        AVG(close) AS avg_close
    FROM tutorial.aapl_historical_stock_price
    GROUP BY YEAR, MONTH
),
MonthlyWithChange AS (
    SELECT 
        yr,
        mn,
        avg_close,
        LAG(avg_close) OVER (ORDER BY yr, mn) AS prev_avg_close
    FROM MonthlyAvg
)
SELECT 
    yr,
    mn,
    avg_close,
   ((avg_close - prev_avg_close) / prev_avg_close) * 100.0 AS mom_percent_change
FROM MonthlyWithChange
--WHERE yr = 2014


