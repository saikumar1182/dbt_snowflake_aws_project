{% set cols = ['property_type', 'room_type', 'country', 'price_per_night'] %}

SELECT 
{% for col in cols %}
{{ col }}{% if not loop.last %},{% endif %}
{% endfor %}
FROM {{ ref('bronze_listings') }}
ORDER BY price_per_night DESC
