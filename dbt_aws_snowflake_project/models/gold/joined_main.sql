{%
    set table_list = [
        {
            "table_name": ref('silver_bookings'),
            "columns": "SILVER_BOOKINGS.*",
            "alias": "SILVER_BOOKINGS"
        },
        {
            "table_name": ref('silver_listings'),
            "columns": "SILVER_LISTINGS.LISTING_ID AS LISTING_LISTING_ID, SILVER_LISTINGS.HOST_ID, SILVER_LISTINGS.PROPERTY_TYPE, SILVER_LISTINGS.ROOM_TYPE, SILVER_LISTINGS.CITY, SILVER_LISTINGS.COUNTRY, SILVER_LISTINGS.ACCOMMODATES, SILVER_LISTINGS.BEDROOMS, SILVER_LISTINGS.BATHROOMS, SILVER_LISTINGS.CREATED_AT AS SILVER_LISTINGS_CREATED_AT, SILVER_LISTINGS.PRICE_PER_NIGHT, SILVER_LISTINGS.PRICE_FLAG",
            "alias": "SILVER_LISTINGS",
            "join_condition": "SILVER_BOOKINGS.LISTING_ID = SILVER_LISTINGS.LISTING_ID"
        },
        {
            "table_name": ref('silver_hosts'),
            "columns": "SILVER_HOSTS.HOST_ID AS HOST_HOST_ID, SILVER_HOSTS.HOST_NAME_CLEANED, SILVER_HOSTS.HOST_SINCE, SILVER_HOSTS.IS_SUPERHOST, SILVER_HOSTS.CREATED_AT AS SILVER_HOSTS_CREATED_AT, SILVER_HOSTS.RESPONSE_RATE, SILVER_HOSTS.RESPONSE_RATE_QUALITY",
            "alias": "SILVER_HOSTS",
            "join_condition": "SILVER_LISTINGS.HOST_ID = SILVER_HOSTS.HOST_ID"
        }
    ]
%}

SELECT 
    {% for table in table_list %}
        {{ table.columns }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM
    {% for table in table_list %}
    {% if loop.first %}
      {{ table.table_name }} AS {{ table.alias }}
    {% else %}
        LEFT JOIN {{ table.table_name }} AS {{ table.alias }}
        ON {{ table.join_condition }}
    {% endif %}
    {% endfor %}