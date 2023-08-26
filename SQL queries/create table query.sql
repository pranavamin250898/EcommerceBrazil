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


-- 5) Membuat ERD dengan cara klik kanan pada database ecommerce_miniproject > Gererate ERD..