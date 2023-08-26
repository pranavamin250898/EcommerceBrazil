use db4;

select * from customers_dataset;

SET SESSION sql_mode=''; 


LOAD DATA INFILE 
'C:/Portfolio Projects/Data/olist_customers_dataset.csv'
INTO TABLE customers_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from customers_dataset;



LOAD DATA INFILE 
'C:/Portfolio Projects/Data/olist_geolocation_dataset.csv'
INTO TABLE geolocation_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;




select * from geolocation_dataset;







LOAD DATA INFILE 
'C:/Portfolio Projects/Data/olist_orders_dataset.csv'
INTO TABLE orders_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- SET SQL_SAFE_UPDATES = 0;


-- DELETE FROM orders_dataset;





select count(*) from orders_dataset;



select * from orders_dataset;





LOAD DATA INFILE 
'C:/Portfolio Projects/Data/olist_sellers_dataset.csv'
INTO TABLE sellers_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


select * from sellers_dataset;









LOAD DATA INFILE 
'C:/Portfolio Projects/Data/olist_order_payments_dataset.csv'
INTO TABLE order_payments_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



select * from order_payments_dataset;







select count(*) from order_payments_dataset;





LOAD DATA INFILE 
'C:/Portfolio Projects/Data/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


select * from order_reviews_dataset;



select count(*) from order_reviews_dataset;



LOAD DATA INFILE 
'C:/Portfolio Projects/Data/olist_products_dataset.csv'
INTO TABLE product_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;




select * from product_dataset;





select count(*) from product_dataset;




LOAD DATA INFILE 
'C:/Portfolio Projects/Data/olist_order_items_dataset.csv'
INTO TABLE order_items_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


select * from order_items_dataset;


select count(*) from order_items_dataset;
  