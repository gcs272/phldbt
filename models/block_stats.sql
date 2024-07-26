{{ config(materialized='table') }}

with average_market_value as (
  select block_id, percentile_cont(0.5) within group (order by market_value) as median,
 avg(market_value) as mean
  from properties_by_block
  group by block_id
), average_violent_crime as (
  select block_id, count(*) as incidents
  from crimes_by_block
  where ucr_general < 500
  group by block_id
), average_nonviolent_crime as (
  select block_id, count(*) as incidents
  from crimes_by_block
  where ucr_general >= 500
  group by block_id
)
select
  block_id,
  median as median_value,
  mean as mean_value,
  avc.incidents as violent_incidents,
  anc.incidents as nonviolent_incidents
from average_market_value amv
  join average_violent_crime as avc on amv.block_id = avc.block_id
  join average_nonviolent_crime as anc on amv.block_id = anc.block_id