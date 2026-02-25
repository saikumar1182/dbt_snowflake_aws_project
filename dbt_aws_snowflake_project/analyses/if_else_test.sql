{% set price_threshold = 200 %}

SELECT * FROM {{ ref('bronze_listings') }}
{% if price_threshold > 100 %}
where price_per_night > {{ price_threshold }}
{%else%}
where price_per_night < {{ price_threshold }}
{%endif%}