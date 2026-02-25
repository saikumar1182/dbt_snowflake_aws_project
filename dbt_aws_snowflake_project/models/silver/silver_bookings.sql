{{
    config(
        materialized='incremental',
        unique_key='booking_id'
    )
}}

SELECT 
    BOOKING_ID,
    LISTING_ID,
    BOOKING_DATE,
    BOOKING_STATUS,
    CREATED_AT,
    BOOKING_AMOUNT,
    NIGHTS_BOOKED,
    CLEANING_FEE,
    SERVICE_FEE,
    {{ multiply('BOOKING_AMOUNT', 'NIGHTS_BOOKED') }} + CLEANING_FEE + SERVICE_FEE as TOTAL_BOOKING_AMOUNT
FROM {{ref('bronze_bookings')}}