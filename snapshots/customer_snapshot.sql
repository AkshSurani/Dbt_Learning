{% snapshot customer_snapshot %}

    {{
        config(
            target_schema='snapshots',
            unique_key="customer_id || '-' || customer_name  || '-' ||  customer_address || '-' || nation_id || '-' || customer_phone || '-' || account_balance || '-' || market_segment  || '-' || customer_comment"  ,
            strategy='check',
            check_cols=['customer_name','customer_address','nation_id',
                        'customer_phone','account_balance',
                        'market_segment','customer_comment']
        )
    }}

    SELECT *
    FROM {{ ref('Stg_Customer') }}

{% endsnapshot %}