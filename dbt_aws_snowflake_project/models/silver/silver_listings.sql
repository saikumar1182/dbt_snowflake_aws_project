{{
      config(
        materialized = 'incremental',
        unique_key = 'listing_id'
      )
}}


SELECT 
    LISTING_ID,
    HOST_ID,
    {{ trim_string('PROPERTY_TYPE') }} as PROPERTY_TYPE,
    ROOM_TYPE,
    CITY,
    COUNTRY,
    ACCOMMODATES,   
    BEDROOMS,
    BATHROOMS,
    CREATED_AT,
    PRICE_PER_NIGHT,
    {{ flag('CAST(PRICE_PER_NIGHT AS INT)') }} as PRICE_FLAG
FROM {{ref('bronze_listings')}}
