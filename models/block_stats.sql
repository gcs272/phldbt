{{ config(materialized='table') }}

with average_market_value as (
    select
        block_id,
        percentile_cont(0.5) within group (order by market_value) as median,
        round(avg(market_value)) as mean,
        count(*) as properties
    from {{ ref('properties_by_block') }}
    group by block_id
),

average_violent_crime as (
    select
        block_id,
        count(*) as incidents
    from {{ ref('crimes_by_block') }}
    where cast(ucr_general as int) < 500
    group by block_id
),

average_nonviolent_crime as (
    select
        block_id,
        count(*) as incidents
    from {{ ref('crimes_by_block') }}
    where cast(ucr_general as int) >= 500
    group by block_id
)

select
    amv.block_id,
    amv.median as median_value,
    amv.mean as mean_value,
    amv.properties,
    avc.incidents as violent_incidents,
    anc.incidents as nonviolent_incidents
from average_market_value as amv
inner join average_violent_crime as avc on amv.block_id = avc.block_id
inner join average_nonviolent_crime as anc on amv.block_id = anc.block_id
