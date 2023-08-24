# 💰 **Analyzing E-Commerce Business Performance with SQL**
<br>

**Tool** : PostgreSQL <br> 
**Visualization** : Microsoft Excel <br>
**Dataset** : Rakamin Academy - [Ecommerce Data]()
<br>
<br>

**Table of Contents**
- [STAGE 0: Problem Statement](https://github.com/faizns/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/README.md#-stage-0:-problem-statement)
	- [Background Story](https://github.com/faizns/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/README.md#background-story)
	- [Objective](https://github.com/faizns/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/README.md#objective)
- [STAGE 1: Data Preparation](https://github.com/faizns/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/README.md#-stage-1:-Data-Preparation)
	- [Create Database and ERD](https://github.com/faizns/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/README.md#create-database-and-erd)
- [STAGE 2: Data Analysis](https://github.com/faizns/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/README.md#-stage-2:-data-analysis)
	- [Annual Customer Activity Growth](https://github.com/faizns/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/README.md#1-annual-customer-activity-growth)
	- [Annual Product Category Quality](https://github.com/faizns/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/README.md#2-annual-product-category-quality)
	- [Annual Payment Type Usage](https://github.com/faizns/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/README.md#3-annual-payment-type-usage)
- [STAGE 3: Summary](https://github.com/faizns/Analyzing-eCommerce-Business-Performance-with-SQL/blob/main/README.md#-stage-3:-summary)
<br>
<br>

---

## 📂 **STAGE 0: Problem Statement**

### **Background Story**
Measuring business performance is very important for a company. This will help in monitoring and assessing the success or failure of various business processes. Measurement of business performance can be done by considering several business metrics. In this project, an analysis of the business performance of an e-commerce company will be carried out using business metrics, namely customer growth, product quality, and payment types based on historical data for three years.

### **Objective**
Gather insight from analysis and visualization in the form of:
1. **Annual Customer Activity Growth**
2. **Annual Product Category Quality**
3. **Annual Payment Type Usage**
<br>
<br>

---

## 📂 **STAGE 1: Data Preparation**

The dataset used is the dataset of a Brazilian eCommerce company that has order information with the number 99441 from 2016 to 2018. There are features that make information such as order status, location, item details, type of payment, and reviews.

### **Create Database and ERD**
**The steps taken include:**
1. 1.	Create a database workspace in pgAdmin and create a table using the CREATE TABLE statement
2. 2.	Import csv data into database
3. 3.	Determine the Primary Key or Foreign Key using  `ALTER TABLE`
4. 4.	Create and export ERD (Entity Relationship Diagram) <br>

<details>
  <summary>Click to view Queries</summary>
  
  ```sql
Create database db4;
use db4;



CREATE TABLE customers_dataset (
  customer_id varchar(100),
  customer_unique_id varchar(100),
  customer_zip_code_prefix varchar(100),
  customer_city varchar(100),
  customer_state varchar(100)
);
CREATE TABLE sellers_dataset (
  seller_id varchar(100),
  seller_zip_code_prefix varchar(100),
  seller_city varchar(100),
  seller_state varchar(100)
);
CREATE TABLE geolocation_dataset (
  geolocation_zip_code_prefix varchar(100),
  geolocation_lat decimal,
  geolocation_lng decimal,
  geolocation_city varchar(100),
  geolocation_state varchar(100)
);
CREATE TABLE product_dataset (
  product_id varchar(100),
  product_category_name varchar(100),
  product_name_lenght int,
  product_description_lenght int,
  product_photos_qty int,
  product_weight_g decimal,
  product_length_cm decimal,
  product_height_cm decimal,
  product_width_cm decimal
);
CREATE TABLE orders_dataset (
  order_id varchar(100),
  customer_id varchar(100),
  order_status varchar(100),
  order_purchase_timestamp timestamp,
  order_approved_at timestamp,
  order_delivered_carrier_date timestamp,
  order_delivered_customer_date timestamp,
  order_estimated_delivery_date timestamp
);
CREATE TABLE order_items_dataset (
  order_id varchar(100),
  order_item_id int,
  product_id varchar(100),
  seller_id varchar(100),
  shipping_limit_date timestamp,
  price decimal,
  fright_value decimal
);
CREATE TABLE order_payments_dataset (
  order_id varchar(100),
  payment_sequential int,
  payment_type varchar(100),
  payment_installments int,
  payment_value decimal
);
CREATE TABLE order_reviews_dataset (
  review_id varchar(100),
  order_id varchar(100),
  review_score int,
  review_comment_title varchar(100),
  review_comment_message varchar(100),
  review_creation_date timestamp,
  review_answer_timestamp timestamp
);

-- 3) Import the csv file into each of the tables that have been created by right-clicking on the table name > Import/Export Data..

-- 4) Determine the Primary Key and Foreign Key to create a relationship between the tables, 
-- Previously, ensure that the Primary Key has a unique value and the data type matches the Primary Key and Foreign Key in the dataset.
-- PRIMARY KEY
ALTER TABLE customers_dataset ADD CONSTRAINT customers_dataset_pkey PRIMARY KEY (customer_id);
ALTER TABLE sellers_dataset ADD CONSTRAINT sellers_dataset_pkey PRIMARY KEY (seller_id);
ALTER TABLE product_dataset ADD CONSTRAINT product_dataset_pkey PRIMARY KEY (product_id);
ALTER TABLE orders_dataset ADD CONSTRAINT orders_dataset_pkey PRIMARY KEY (order_id);


-- FOREIGN KEY
 ALTER TABLE orders_dataset ADD FOREIGN KEY (customer_id) REFERENCES customers_dataset (customer_id);
ALTER TABLE order_payments_dataset ADD FOREIGN KEY (order_id) REFERENCES orders_dataset (order_id);
ALTER TABLE order_reviews_dataset ADD FOREIGN KEY (order_id) REFERENCES orders_dataset (order_id);
ALTER TABLE order_items_dataset ADD FOREIGN KEY (order_id) REFERENCES orders_dataset (order_id);
ALTER TABLE order_items_dataset ADD FOREIGN KEY (product_id) REFERENCES product_dataset (product_id);
ALTER TABLE order_items_dataset ADD FOREIGN KEY (seller_id) REFERENCES sellers_dataset (seller_id);


-- 5) Create ERD by right-clicking on the ecommerce_miniproject database > Generate ERD..
  ```
</details>

**Hasil ERD :** <br>
<p align="center">
  <kbd><img src="asset/gambar_1_ERD.png" width=800px> </kbd> <br>
  Gambar 1. Entity Relationship Diagram
</p>
<br>
<br>

---

## 📂 **STAGE 2: Data Analysis**

### **1. Annual Customer Activity Growth**
Pertumbuhan aktivitas pelanggan tahunan dapat dianalisis dari Monthly active user (MAU), pelanggan baru, pelanggan dengan repeat order, dan rata-rata order oleh pelanggan.

<details>
  <summary>Click to view Queries</summary>
  
  ```sql
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
  ```
</details>

<p align="center">
Tabel 1. Results of Annual Customer Activity Growth Analysis  <br>
  <kbd><img src="asset/activity.png" width=800px> </kbd> <br>
</p>

<br>
<p align="center">
  <kbd><img src="asset/gambar_2_mau_x_newcust.png" width=600px> </kbd> <br>
  Gambar 2. Grafik Rata-rata MAU dan Pelanggan Baru
</p>

Secara keseluruhan perusahaan mengalami peningkakatan Monthly Active User serta pelanggan baru setiap tahunnya. Peningkatan yang signifikan terjadi pada tahun 2016 ke 2017, hal ini dikarenakan data transaksi pada tahun 2016 dimulai pada bulan September. <br>
<br>
<br>

<p align="center">
  <kbd><img src="asset/gambar_3_repeat order.png" width=600px> </kbd> <br>
