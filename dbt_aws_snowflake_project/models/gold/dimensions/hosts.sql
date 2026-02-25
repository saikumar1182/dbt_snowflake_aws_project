{{
  config(
    materialized = 'ephemeral',
    )
}}

WITH hosts AS 
(
    SELECT 
        HOST_ID,
        HOST_NAME_CLEANED,
        HOST_SINCE,
        IS_SUPERHOST,
        RESPONSE_RATE_QUALITY,
        SILVER_HOSTS_CREATED_AT AS HOSTS_CREATED_AT
    FROM 
        {{ ref('joined_main') }}
)

SELECT * FROM hosts