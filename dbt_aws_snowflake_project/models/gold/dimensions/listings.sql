{{
  config(
    materialized = 'ephemeral',
    )
}}

WITH listings AS 
(
    SELECT 
        LISTING_ID,
        PROPERTY_TYPE,
        ROOM_TYPE,
        CITY,
        COUNTRY,
        PRICE_FLAG,
        SILVER_LISTINGS_CREATED_AT AS LISTINGS_CREATED_AT
    FROM 
        {{ ref('joined_main') }}
)
SELECT * FROM listings