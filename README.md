# store_hse
# Аналитический слой интернет-магазина (dbt + Greenplum)

## Модель данных

```mermaid
erDiagram
    dim_customers ||--o{ fct_orders : "customer_id"
    dim_dates ||--o{ fct_orders : "order_date"
    dim_products ||--o{ fct_order_items : "product_id"
    fct_orders ||--|{ fct_order_items : "order_id"
    dim_customers ||--o{ fct_order_items : "customer_id"
    dim_dates ||--o{ fct_order_items : "order_date"