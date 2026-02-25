{{
    config(
        materialized = 'incremental',
        unique_key = 'host_id'
    )
}}

select 
    HOST_ID,
    REPLACE('HOST_NAME', ' ', '_') AS HOST_NAME_CLEANED,
    HOST_SINCE,
    IS_SUPERHOST,
    CREATED_AT,
    RESPONSE_RATE,
    CASE 
        WHEN RESPONSE_RATE > 90 THEN 'VERY RESPONSIVE'
        WHEN RESPONSE_RATE >= 70 AND RESPONSE_RATE < 90 THEN 'RESPONSIVE'
        WHEN RESPONSE_RATE >= 50 AND RESPONSE_RATE < 70 THEN 'FAIR RESPONSE'
        ELSE 'SLOW RESPONSE'
    END AS RESPONSE_RATE_QUALITY,
FROM {{ ref('bronze_hosts') }}
    