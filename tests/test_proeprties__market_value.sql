with properties_under_1_dollar as (
  select count(*) as parcels from {{ ref('properties') }}
  where market_value <= 1.0
), properties_over_100_mil as (
  select count(*) as parcels from {{ ref('properties') }}
  where market_value >= 100000000
)
select * from properties_under_1_dollar where parcels > 500 union
select * from properties_over_100_mil where parcels > 500
