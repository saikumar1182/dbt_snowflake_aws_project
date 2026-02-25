# Multiplying columns macro
{% macro multiply(column_name1, column_name2) %}
    {{ column_name1 }} * {{ column_name2 }}
{% endmacro %}


# Trimming and uppercasing string macro
{% macro trim_string(column_name) %}
    {{ column_name | trim | upper }}
{% endmacro %}


# Flagging column macro
{% macro flag(column) %}
    CASE 
        WHEN {{ column }} < 100 THEN 'low'
        WHEN {{ column }} >= 100 AND {{ column }} < 200 THEN 'medium'
        ELSE 'high'
    END
{% endmacro %}