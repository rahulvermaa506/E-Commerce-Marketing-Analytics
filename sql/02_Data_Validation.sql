-------------------------------------------------------- DATAVAIDATION --------------------------------------------------------------------------------------

------------------------------------------------------------ORDER TABLE -------------------------------------------------------------------------------------
--TABLE VIEW 

SELECT TOP 5 * FROM ORDERS

-- ORDER PURCHASE DATE IS LESS THEN ORDER APPROVED ,  ORDER DELIVERED CARRIER , ORDER DELIVERED CUSTOMER AND ORDER ESTIMATED DELIVERY DATE 


SELECT * FROM ORDERS
WHERE TRY_CONVERT(datetime , order_purchase_timestamp) > TRY_CONVERT(datetime , order_approved_at) 
AND  TRY_CONVERT(datetime , order_purchase_timestamp) > TRY_CONVERT(datetime , order_delivered_carrier_date)
AND TRY_CONVERT(datetime , order_purchase_timestamp) > TRY_CONVERT(datetime , order_delivered_customer_date)
AND TRY_CONVERT(datetime , order_purchase_timestamp) > TRY_CONVERT(datetime , order_estimated_delivery_date) 

-- ZERO ERROR

-- ORDER APPROVED DATE IS LESS THAN ORDER DELIVER CUSTOMER 

SELECT * FROM ORDERS
WHERE TRY_CONVERT(datetime , order_delivered_customer_date) < TRY_CONVERT(datetime , order_approved_at) 

-- ERROR 61 ROWS order_delivered_customer_date < order_approved_at
/*
order_id	customer_id	order_status	order_purchase_timestamp	order_approved_at	order_delivered_carrier_date	order_delivered_customer_date	order_estimated_delivery_date
58d4c4747ee059eeeb865b349b41f53a	1755fad7863475346bc6c3773fe055d3	delivered	7/21/2018 12:49	7/26/2018 23:31	7/24/2018 12:57	7/25/2018 23:58	7/31/2018 0:00
4df92d82d79c3b52c7138679fa9b07fc	ba0660bf3fffe505ee892e153a2fbd49	delivered	7/24/2018 11:32	7/29/2018 23:30	7/26/2018 14:46	7/27/2018 18:55	8/6/2018 0:00
6e57e23ecac1ae881286657694444267	2dda54e25d0984e12705c84d4030e6e0	delivered	8/9/2018 17:36	8/20/2018 15:55	8/14/2018 13:26	8/17/2018 16:45	9/6/2018 0:00
f222c56f035b47dfa1e069a88235d730	b74ca180d63f9ae0443e4e13a2f5bdaf	delivered	1/30/2018 9:43	2/4/2018 23:31	1/31/2018 19:48	2/1/2018 20:10	2/15/2018 0:00
cf72398d0690f841271b695bbfda82d2	2b7fff075bda701552485ef3f0810257	delivered	9/1/2017 18:45	9/13/2017 22:04	9/4/2017 20:12	9/11/2017 14:15	9/21/2017 0:00
*/


-- ORDER DELIVERED CARRIER DATE IS LESS THAN ORDER DELIVER CUSTOMER DATE 

SELECT * FROM ORDERS
WHERE TRY_CONVERT(datetime , order_delivered_customer_date) < TRY_CONVERT(datetime , order_delivered_carrier_date) 

-- ERROR 23 ROWS FIND ERROR order_delivered_customer_date < order_delivered_carrier_date
/*
order_id	customer_id	order_status	order_purchase_timestamp	order_approved_at	order_delivered_carrier_date	order_delivered_customer_date	order_estimated_delivery_date
1cc3ae63caffff2d6c3ee3e78e074acf	01c843a2c0600def0b7693dba47af460	delivered	8/7/2017 21:35	8/8/2017 21:45	8/10/2017 18:28	8/10/2017 18:05	8/25/2017 0:00
e37f11cae9985ca58f0b56f268720537	3947a361301f2ff0f3223159a0f2701c	delivered	7/26/2017 11:46	7/27/2017 10:10	8/1/2017 18:17	7/31/2017 17:49	8/24/2017 0:00
fa3e37584f4fdb1ded0e0de700dfcb4e	63be4feff10a0b1d85f2cfbf10df9754	delivered	7/30/2017 19:32	7/30/2017 19:45	8/9/2017 18:18	8/1/2017 21:13	8/18/2017 0:00
c1e2bf2b7dd3309f2f5356c6b63968fa	e37d47e7eec62f08dc5deecc7d5532d6	delivered	2/10/2017 10:19	2/10/2017 10:30	3/2/2017 17:34	2/14/2017 15:15	3/15/2017 0:00
b866af202be0692766081310cd4085e1	d1800078046ed2e5ae1b0792b695c56e	delivered	1/27/2017 14:59	1/27/2017 15:30	2/20/2017 2:32	2/15/2017 3:53	4/17/2017 0:00
*/

-- ORDER TABLE ALL CUSTOMER ID IS PRESENT IN CUSTOMER TABLE CHECK 

SELECT O.customer_id FROM ORDERS AS O
LEFT JOIN CUSTOMERS AS C
ON O.customer_id = C.customer_id
WHERE C.customer_id IS NULL

-- ZERO 

-- CHECK ORDER ID IS NOT PRESENT IN ORDER ITEM

SELECT O.order_id FROM ORDERS AS O
LEFT JOIN ORDER_ITEMS AS OT ON O.order_id = OT.order_id
WHERE OT.order_id IS NULL

-- ERROR 775 ROWS ORDER ID IS NOT PRESENT IN ORDER ITEM TABEL
/*
order_id
5a00b4d35edffc56b825c3646a99ba9d
6338011716bfe53b960847be47479662
c609f82bcf7a90292a5940205ebd7e93
a0141c1141d9406b48466fe4d1492bf4
9abe82df39e950e1e0c1a5969e22571e
*/
-- CHECK ORDER ID IS NOT PRESENT IN PAYMENT TABEL 

SELECT O.order_id FROM ORDERS AS O
LEFT JOIN ORDER_PAYMENTS AS P ON O.order_id = P.order_id
WHERE P.order_id IS NULL

-- ERROR 1 PAYMENT ORDER ID IS NOT AVILABEL
/*
order_id
bfbd0f9bdef84302105ad712db648a6c
*/

------------------------------------------------------------ORDER ITEM TABEL --------------------------------------------------------------------------
 -- TABEL VIEW 
 SELECT TOP 5 * FROM ORDER_ITEMS

 -- ORDER ITEM TABLE CHECK ALL ORDER ID AND PRODUCT ID AND SELLER ID IS PRESET IN ORDER , PRODUCT ,  SELLER TABLE 

-- ORDER ID CHECK 

SELECT OT.order_id FROM ORDER_ITEMS AS OT
LEFT JOIN ORDERS AS O
ON OT.order_id = O.order_id
WHERE O.order_id IS NULL

-- PRODUCT ID CHECK 

SELECT OT.product_id FROM ORDER_ITEMS AS OT
LEFT JOIN PRODUCTS AS P
ON OT.product_id = P.product_id
WHERE P.product_id IS NULL;

-- SELLER ID 

SELECT OT.seller_id FROM ORDER_ITEMS AS OT
LEFT JOIN SELLERS AS S
ON OT.seller_id = S.seller_id
WHERE S.seller_id IS NULL;


-- ZERO 


 --   PRICE CHECK 

 SELECT * FROM ORDER_ITEMS
 WHERE TRY_CONVERT(decimal(10,2),price) <=0

 -- FRIEGHT VALUE

 SELECT * FROM ORDER_ITEMS
 WHERE TRY_CONVERT(decimal(10,2),freight_value) <0


---------------------------------------------------------------- ORDER PAYMENT TABEL ------------------------------------------------------------------

-- TABEL VIEW 

SELECT TOP 5 * FROM ORDER_PAYMENTS

-- ORDER ID CHECK 
SELECT P.order_id FROM ORDER_PAYMENTS AS P
LEFT JOIN ORDERS AS O
ON P.order_id = O.order_id
WHERE O.order_id IS NULL

--ZERO

SELECT P.order_id FROM ORDER_PAYMENTS AS P
LEFT JOIN ORDER_ITEMS AS OT
ON P.order_id = OT.order_id
WHERE OT.order_id IS NULL

-- ERROR 830 ROWS  PAYMENT ORDER ID IS NOT AVILABEL ORDER_ITEM ORDER_ID 

-- payment value 

 SELECT * FROM ORDER_PAYMENTS
 WHERE TRY_CONVERT(decimal(10,2),payment_value) <=0

 -- ERROR 9 ROWS 
 /*
 order_id	payment_sequential	payment_type	payment_installments	payment_value
8bcbe01d44d147f901cd3192671144db	4	voucher	1	0
fa65dad1b0e818e3ccc5cb0e39231352	14	voucher	1	0
6ccb433e00daae1283ccc956189c82ae	4	voucher	1	0
 */

 --------------------------------------------------------------------ORDER PRODUCT TABEL --------------------------------------------------------------

 -- TABEL VIEW 
 SELECT TOP 5 * FROM PRODUCTS


-- WEIGHT_G
SELECT * FROM PRODUCTS
WHERE TRY_CONVERT(decimal(10,2),product_weight_g) <=0

-- ERROR 3 ROWS PRODUCTS
/*
product_id	product_category_name	product_name_lenght	product_description_lenght	product_photos_qty	product_weight_g	product_length_cm	product_height_cm	product_width_cm
81781c0fed9fe1ad6e8c81fca1e1cb08	Bed_Bath_Table	51	529	1	0	30	25	30
8038040ee2a71048d4bdbbdc985b69ab	Bed_Bath_Table	48	528	1	0	30	25	30
36ba42dd187055e1fbe943b2d11430ca	Bed_Bath_Table	53	528	1	0	30	25	30
e673e90efa65a5409ff4196c038bb5af	Bed_Bath_Table	53	528	1	0	30	25	30
*/

--------------------------------------------------------------------ORDER REVIEW TABEL -----------------------------------------------------------------
-- TABEL VIEW 
SELECT TOP 5 * FROM ORDER_REVIEW_RATINGS

-- ORDER ID IS CHECK 

SELECT R.order_id FROM ORDER_REVIEW_RATINGS AS R
LEFT JOIN ORDERS AS O
ON R.order_id = O.order_id
WHERE R.order_id IS NULL

-- ZERO

-- RANGE 1 TO 5 REVIEW RATING 

SELECT * FROM ORDER_REVIEW_RATINGS
WHERE TRY_CONVERT(INT, review_score) NOT BETWEEN 1 AND 5

--ZERO

---------------------------------------------------------------------SELLER TABEL ----------------------------------------------------------------------

-- TABEL VIEW 
SELECT TOP 5 * FROM SELLERS

-- ZIP CODE CHECK 

SELECT S.seller_zip_code_prefix FROM SELLERS AS S
LEFT JOIN GEO_LOCATION AS G
ON S.seller_zip_code_prefix = G.geolocation_zip_code_prefix
WHERE G.geolocation_zip_code_prefix IS NULL

-- SOME ZIP CODE IS NOT AVILABEL
/*
seller_zip_code_prefix
71551
72580
2285
82040
91901
37708
7412
*/












