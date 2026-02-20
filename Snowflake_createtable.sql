CREATE WAREHOUSE IF NOT EXISTS COMPUTE_WH;
USE WAREHOUSE COMPUTE_WH; 

CREATE DATABASE IF NOT EXISTS AIRBNB;
CREATE SCHEMA IF NOT EXISTS AIRBNB.RAW;
CREATE SCHEMA IF NOT EXISTS AIRBNB.DEV;

USE DATABASE AIRBNB;
USE SCHEMA RAW; 


-- Create our three tables and import the data from S3
CREATE OR REPLACE TABLE raw_hosts (
    id integer,
    name STRING,
    is_superhost string,
    created_at string,
    updated_at datetime);
COPY INTO raw_hosts (id, name,is_superhost, created_at,updated_at)
    from 's3://demo-snow-bucket-ben/demo-snow-bucket-ben/hosts.csv'
     FILE_FORMAT = (type = 'CSV' skip_header= 1
     FIELD_OPTIONALLY_ENCLOSED_BY= '"');

CREATE OR REPLACE TABLE raw_listings
                    (id string,
                     listing_url string,
                     name string,
                     room_type string,
                     minimum_nights string,
                     host_id string,
                     price string,
                     created_at string,
                     updated_at string);
COPY INTO raw_listings (id,
                        listing_url,
                        name,
                        room_type,
                        minimum_nights,
                        host_id,
                        price,
                        created_at,
                        updated_at)
                   from 's3://demo-snow-bucket-ben/demo-snow-bucket-ben/listings.csv'
                    FILE_FORMAT = (type = 'CSV' skip_header = 1
                    FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_bookings (
    booking_id string,
    listing_id integer,
    booking_date datetime,
    nights_booked integer,
    booking_amount integer,
    cleaning_fee integer,
    service_fee integer,
    booking_status string,
    created_at datetime);
    
COPY INTO raw_bookings (
    booking_id,
    listing_id,
    booking_date,
    nights_booked,
    booking_amount,
    cleaning_fee,
    service_fee,
    booking_status,
    created_at)
from 's3://demo-snow-bucket-ben/demo-snow-bucket-ben/bookings.csv'
    FILE_FORMAT = (type = 'CSV' skip_header = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"');
 

CREATE OR REPLACE TABLE raw_reviews
                    (listing_id integer,
                     date datetime,
                     reviewer_name string,
                     comments string,
                     sentiment string);

COPY INTO raw_reviews (listing_id, date, reviewer_name, comments, sentiment)
                   from 's3://demo-snow-bucket-ben/demo-snow-bucket-ben/reviews.csv'
                    FILE_FORMAT = (type = 'CSV' skip_header = 1
                    FIELD_OPTIONALLY_ENCLOSED_BY = '"');
