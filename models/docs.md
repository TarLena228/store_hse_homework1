{% docs __overview__ %}
# Аналитический слой интернет-магазина

Проект dbt в Greenplum. Слои: staging, intermediate, marts.

Витрины по схеме «звезда»:
- факты: `fct_orders`, `fct_order_items`;
- измерения: `dim_customers`, `dim_products`, `dim_dates`.
{% enddocs %}

{% docs confirmed_order %}
Подтверждённая покупка: заказ со статусом `paid` и хотя бы одной успешной оплатой. Возврат оплатой не считается.

Тест `assert_confirmed_not_overcharged` находит заказ 113: оплачено 400 при сумме заказа 200 (два списания по 200). Тест настроен как `warn`, данные не менялись.
{% enddocs %}