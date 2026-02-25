{% set table_list = [
    {
        "table" : ref('joined_main'),
        "columns" : "MAIN_TABLE.BOOKING_ID, MAIN_TABLE.LISTING_ID, MAIN_TABLE.HOST_ID,MAIN_TABLE.TOTAL_BOOKING_AMOUNT, MAIN_TABLE.SERVICE_FEE, MAIN_TABLE.CLEANING_FEE, MAIN_TABLE.ACCOMMODATES, MAIN_TABLE.BEDROOMS, MAIN_TABLE.BATHROOMS, MAIN_TABLE.PRICE_PER_NIGHT, MAIN_TABLE.RESPONSE_RATE",
        "alias" : "MAIN_TABLE"
    },
    { 
        "table" : ref('dim_listings'),
        "columns" : "",
        "alias" : "DIM_LISTINGS",
        "join_condition" : "MAIN_TABLE.LISTING_ID = DIM_LISTINGS.LISTING_ID"
    },
    {
        "table" : ref('dim_hosts'),
        "columns" : "",
        "alias" : "DIM_HOSTS",
        "join_condition" : "MAIN_TABLE.HOST_ID = DIM_HOSTS.HOST_ID"
    }
] %}



SELECT 
        {{ table_list[0]['columns'] }}

FROM
    {% for table in table_list %}
    {% if loop.first %}
      {{ table['table'] }} AS {{ table['alias'] }}
    {% else %}
        LEFT JOIN {{ table['table'] }} AS {{ table['alias'] }}
        ON {{ table['join_condition'] }}
        {% endif %}
        {% endfor %}