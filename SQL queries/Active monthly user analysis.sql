use db4;


-- 1 Displays the average number of monthly active users (monthly active users) for each year

SELECT 
    year,
    FLOOR(AVG(customer_total)) AS avg_mau
FROM (
    SELECT 
        EXTRACT(year FROM od.order_purchase_timestamp) AS year,
        EXTRACT(month FROM od.order_purchase_timestamp) AS month,
        COUNT(DISTINCT cd.customer_unique_id) AS customer_total
    FROM orders_dataset AS od
    JOIN customers_dataset AS cd
        ON cd.customer_id = od.customer_id
    GROUP BY 1, 2
) AS sub
GROUP BY year
ORDER BY year;


-- Create a new table to store the results
CREATE TABLE avg_mau_table (
    year INT PRIMARY KEY,
    avg_mau INT
);

-- Insert the computed averages into the new table
INSERT INTO avg_mau_table (year, avg_mau)
SELECT 
    year,
    FLOOR(AVG(customer_total)) AS avg_mau
FROM (
    SELECT 
        EXTRACT(year FROM od.order_purchase_timestamp) AS year,
        EXTRACT(month FROM od.order_purchase_timestamp) AS month,
        COUNT(DISTINCT cd.customer_unique_id) AS customer_total
    FROM orders_dataset AS od
    JOIN customers_dataset AS cd
        ON cd.customer_id = od.customer_id
    GROUP BY 1, 2
) AS sub
GROUP BY year
ORDER BY year;



-- 2 Displays the number of new customers in each year

SELECT 
    year,
    COUNT(customer_unique_id) AS total_new_customer
FROM (
    SELECT
        EXTRACT(year FROM od.order_purchase_timestamp) AS year,
        cd.customer_unique_id
    FROM orders_dataset AS od
    JOIN customers_dataset AS cd
        ON cd.customer_id = od.customer_id
    GROUP BY year, cd.customer_unique_id
) AS sub
GROUP BY year
ORDER BY year;





-- 3 Displays the number of customer repeat orders in each year




SELECT 
    year,
    COUNT(customer_unique_id) AS total_customer_repeat
FROM (
    SELECT
        EXTRACT(year FROM od.order_purchase_timestamp) AS year,
        cd.customer_unique_id,
        COUNT(od.order_id) AS total_order
    FROM orders_dataset AS od
    JOIN customers_dataset AS cd
        ON cd.customer_id = od.customer_id
    GROUP BY year, cd.customer_unique_id
    HAVING COUNT(od.order_id) > 1
) AS sub
GROUP BY year
ORDER BY year;



-- 4 Displays the average number of orders made by customers for each year





SELECT 
    year,
    ROUND(AVG(freq), 3) AS avg_frequency
FROM (
    SELECT
        EXTRACT(year FROM od.order_purchase_timestamp) AS year,
        cd.customer_unique_id,
        COUNT(od.order_id) AS freq
    FROM orders_dataset AS od
    JOIN customers_dataset AS cd
        ON cd.customer_id = od.customer_id
    GROUP BY year, cd.customer_unique_id
) AS sub
GROUP BY year
ORDER BY year;


-- 5 Combines the three metrics that have been successfully displayed into one table view

SET GLOBAL wait_timeout = 600;



SET GLOBAL interactive_timeout = 600;


SET @@local.net_read_timeout=360;


WITH cte_mau AS (
  SELECT year, FLOOR(AVG(customer_total)) AS avg_mau
  FROM (
    SELECT 
      EXTRACT(year FROM od.order_purchase_timestamp) AS year,
      EXTRACT(month FROM od.order_purchase_timestamp) AS month,
      COUNT(DISTINCT cd.customer_unique_id) AS customer_total
    FROM orders_dataset AS od
    JOIN customers_dataset AS cd
      ON cd.customer_id = od.customer_id
    GROUP BY 1, 2
  ) AS sub
  GROUP BY year
),

cte_new_cust AS (
  SELECT year, COUNT(customer_unique_id) AS total_new_customer
  FROM (
    SELECT
      MIN(EXTRACT(year FROM od.order_purchase_timestamp)) AS year,
      cd.customer_unique_id
    FROM orders_dataset AS od
    JOIN customers_dataset AS cd
      ON cd.customer_id = od.customer_id
    GROUP BY 2
  ) AS sub
  GROUP BY year
),

cte_repeat_order AS (
  SELECT year, COUNT(customer_unique_id) AS total_customer_repeat
  FROM (
    SELECT
      EXTRACT(year FROM od.order_purchase_timestamp) AS year,
      cd.customer_unique_id,
      COUNT(od.order_id) AS total_order
    FROM orders_dataset AS od
    JOIN customers_dataset AS cd
      ON cd.customer_id = od.customer_id
    GROUP BY 1, 2
    HAVING COUNT(od.order_id) > 1
  ) AS sub
  GROUP BY year
),

cte_frequency AS (
  SELECT year, ROUND(AVG(freq), 3) AS avg_frequency
  FROM (
    SELECT
      EXTRACT(year FROM od.order_purchase_timestamp) AS year,
      cd.customer_unique_id,
      COUNT(order_id) AS freq
    FROM orders_dataset AS od
    JOIN customers_dataset AS cd
      ON cd.customer_id = od.customer_id
    GROUP BY 1, 2
  ) AS sub
  GROUP BY year
)

SELECT
  mau.year AS year,
  avg_mau,
  total_new_customer,
  total_customer_repeat,
  avg_frequency
FROM
  cte_mau AS mau
  JOIN cte_new_cust AS nc
    ON mau.year = nc.year
  JOIN cte_repeat_order AS ro
    ON nc.year = ro.year
  JOIN cte_frequency AS f
    ON ro.year = f.year
ORDER BY year;
