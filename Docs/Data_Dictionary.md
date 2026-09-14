# Data Dictionary

## Customers

| Column | Description |
|---|---|
| customer_id | Unique customer record identifier used to link customers with orders |
| customer_unique_id | Business-level unique customer identifier used for customer behavior analysis |
| customer_zip_code_prefix | Customer location ZIP code prefix |
| customer_city | Customer city |
| customer_state | Customer state |

## Orders

| Column | Description |
|---|---|
| order_id | Unique order identifier |
| customer_id | Customer associated with the order |
| order_status | Current status of the order |
| order_purchase_timestamp | Date and time when the order was placed |
| order_approved_at | Date and time when the order was approved |
| order_delivered_carrier_date | Date when the order was handed to the carrier |
| order_delivered_customer_date | Date when the order was delivered to the customer |
| order_estimated_delivery_date | Estimated delivery date |

## Order Items

| Column | Description |
|---|---|
| order_id | Order associated with the item |
| order_item_id | Item sequence number within an order |
| product_id | Product associated with the order item |
| seller_id | Seller associated with the order item |
| shipping_limit_date | Seller shipping deadline |
| price | Product item price |
| freight_value | Freight/shipping value |

## Products

| Column | Description |
|---|---|
| product_id | Unique product identifier |
| product_category_name | Product category |
| product_name_lenght | Product name length |
| product_description_lenght | Product description length |
| product_photos_qty | Number of product photos |
| product_weight_g | Product weight in grams |
| product_length_cm | Product length in centimeters |
| product_height_cm | Product height in centimeters |
| product_width_cm | Product width in centimeters |

## Sellers

| Column | Description |
|---|---|
| seller_id | Unique seller identifier |
| seller_zip_code_prefix | Seller ZIP code prefix |
| seller_city | Seller city |
| seller_state | Seller state |

## Order Payments

| Column | Description |
|---|---|
| order_id | Order associated with the payment |
| payment_sequential | Payment sequence number within an order |
| payment_type | Payment method |
| payment_installments | Number of payment installments |
| payment_value | Payment amount |

## Order Review Ratings

| Column | Description |
|---|---|
| review_id | Review identifier |
| order_id | Order associated with the review |
| review_score | Customer rating score |
| review_creation_date | Review creation date |
| review_answer_timestamp | Review response timestamp |

## Geo Location

| Column | Description |
|---|---|
| geolocation_zip_code_prefix | ZIP code prefix |
| geolocation_lat | Geographic latitude |
| geolocation_lng | Geographic longitude |
| geolocation_city | Geographic city |
| geolocation_state | Geographic state |
