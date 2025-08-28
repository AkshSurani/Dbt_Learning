{% macro generate_schema_name(custom_schema_name, node) -%}

    {# Default schema from dbt profile #}
    {%- set default_schema = target.schema -%}

    {%- if custom_schema_name is not none -%}
        {# If a custom schema is explicitly provided, append it to the default (dbt default behavior) #}
        {{ default_schema }}_{{ custom_schema_name | trim }}
    {%- else -%}
        {# No custom schema provided: determine based on model folder path #}
        {%- set path = node.path | lower -%}

        {%- if 'staging/' in path -%}
            SF1_STAGING
        {%- elif 'intermediate/' in path -%}
            SF1_INTERMEDIATE
        {%- elif 'analytics/' in path -%}
            SF1_ANALYTICS
        {%- else -%}
            {{ default_schema }}
        {%- endif -%}
    {%- endif -%}

{%- endmacro %}