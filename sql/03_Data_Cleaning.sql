-- CLEAN TABLE CREATE 

------------------------------------------------------------CUSTOMER TABLE------------------------------------------------------------------------------

SELECT 
customer_id ,
customer_unique_id ,
TRY_CONVERT(VARCHAR(10),customer_zip_code_prefix) AS customer_zip_code_prefix,
LTRIM(RTRIM(customer_city)) AS customer_city ,
LTRIM(RTRIM(customer_state)) AS customer_state
INTO CLEAN.CUSTOMERS_CLEAN
FROM CUSTOMERS;


SELECT TOP 10 * FROM CLEAN.CUSTOMERS_CLEAN ;



----------------------------------------------------------------ORDER TABLE ----------------------------------------------------------------------------

SELECT  
order_id ,
customer_id ,
order_status, 
TRY_CONVERT(datetime,order_purchase_timestamp) AS order_purchase_timestamp,
TRY_CONVERT(datetime,order_approved_at) AS order_approved_at ,
TRY_CONVERT(datetime,order_delivered_carrier_date) AS order_delivered_carrier_date ,
TRY_CONVERT(datetime,order_delivered_customer_date) AS order_delivered_customer_date,
TRY_CONVERT(datetime,order_estimated_delivery_date) AS order_estimated_delivery_date ,
MONTH(TRY_CONVERT(datetime,order_purchase_timestamp)) AS purchase_month ,
DATENAME(MONTH ,TRY_CONVERT(datetime,order_purchase_timestamp)) AS purchase_month_name ,
YEAR(TRY_CONVERT(datetime,order_purchase_timestamp)) AS purchase_year ,
CASE WHEN order_approved_at IS NULL THEN 1 ELSE 0 END AS order_approved_at_missing_flag ,
CASE WHEN order_delivered_carrier_date IS NULL THEN 1 ELSE 0 END AS order_delivered_carrier_missing_flag ,
CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END AS order_delivered_customer_missing_flag
INTO CLEAN.ORDERS_CLEAN
FROM ORDERS ;

SELECT TOP 10 * FROM CLEAN.ORDERS_CLEAN ;




------------------------------------------------------------ORDER ITEM TABLE---------------------------------------------------------------------------

SELECT 
order_id , 
TRY_CONVERT(INT,order_item_id) AS  order_item_id , 
product_id , 
seller_id , 
TRY_CONVERT(datetime, shipping_limit_date) AS shipping_limit_date,
TRY_CONVERT(decimal(10,2),price) AS price ,
TRY_CONVERT(decimal(10,2),freight_value) AS freight_value
INTO CLEAN.ORDER_ITEMS_CLEAN
FROM ORDER_ITEMS ;

SELECT TOP 10 * FROM CLEAN.ORDER_ITEMS_CLEAN



------------------------------------------------------------------ORDER PAYMENT TABLE -----------------------------------------------------------------

 SELECT order_id,
 TRY_CONVERT(int,payment_sequential) as payment_sequential ,
 LTRIM(RTRIM(payment_type)) AS payment_type ,
 TRY_CONVERT(INT,payment_installments) AS payment_installments ,
 TRY_CONVERT(decimal(10,2),payment_value) AS payment_value
 INTO CLEAN.ORDER_PAYMENTS_CLEAN
 FROM ORDER_PAYMENTS

 SELECT TOP 10 * FROM CLEAN.ORDER_PAYMENTS_CLEAN

-----------------------------------------------------------------ORDER REVIEW RATINGS TABLE------------------------------------------------------------


SELECT 
review_id ,
order_id , 
TRY_CONVERT(INT , review_score) AS review_score,
TRY_CONVERT(datetime , review_creation_date) AS review_creation_date , 
TRY_CONVERT(datetime , review_answer_timestamp) AS review_answer_timestamp
INTO CLEAN.ORDER_REVIEW_RATINGS_CLEAN
FROM ORDER_REVIEW_RATINGS



------------------------------------------------------------------- PRODUCTS TABLE --------------------------------------------------------------------

SELECT 
product_id,
LTRIM(RTRIM(product_category_name)) AS product_category_name,
TRY_CONVERT(INT,product_name_lenght) AS product_name_lenght , 
TRY_CONVERT(INT,product_description_lenght) AS product_description_lenght,
TRY_CONVERT(INT,product_photos_qty) AS product_photos_qty ,
TRY_CONVERT(decimal(10,2), product_weight_g) AS product_weight_g,
TRY_CONVERT(decimal(10,2), product_length_cm) AS product_length_cm,
TRY_CONVERT(decimal(10,2), product_height_cm) AS product_height_cm,
TRY_CONVERT(decimal(10,2), product_width_cm) AS product_width_cm
INTO CLEAN.PRODUCTS_CLEAN
FROM PRODUCTS


SELECT TOP 10 * FROM CLEAN.PRODUCTS_CLEAN

-------------------------------------------------------------------GEO_LOCATION TABLE -----------------------------------------------------------------
SELECT TOP 10 * FROM GEO_LOCATION

SELECT 
TRY_CONVERT(varchar(10),geolocation_zip_code_prefix) AS geolocation_zip_code_prefix ,
geolocation_lat,
geolocation_lng,
LTRIM(RTRIM(geolocation_city)) AS geolocation_city,
LTRIM(RTRIM(geolocation_state)) AS geolocation_state
INTO CLEAN.GEO_LOCATION_CLEAN
FROM GEO_LOCATION

SELECT TOP 10 * FROM CLEAN.GEO_LOCATION_CLEAN

------------------------------------------------------------------- SELLER TABLE ----------------------------------------------------------------------


SELECT 
seller_id,
TRY_CONVERT(varchar(10),seller_zip_code_prefix) AS seller_zip_code_prefix ,
LTRIM(RTRIM(seller_city)) AS seller_city , 
LTRIM(RTRIM(seller_state)) AS seller_state
INTO CLEAN.SELLERS_CLEAN
FROM SELLERS S 



SELECT TOP 10 * FROM CLEAN.SELLERS_CLEAN


SELECT *
FROM SELLERS S 
LEFT JOIN GEO_LOCATION G 
ON S.seller_zip_code_prefix = G.geolocation_zip_code_prefix
WHERE S.seller_state ='#N/A'

-- 57 ROWS 

UPDATE S
SET S.seller_city = G.geolocation_city ,S.seller_state = G.geolocation_state 
FROM CLEAN.SELLERS_CLEAN S 
JOIN CLEAN.GEO_LOCATION_CLEAN G
ON S.seller_zip_code_prefix = G.geolocation_zip_code_prefix
WHERE S.seller_state ='#N/A'

