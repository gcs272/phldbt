{{ config(materialized='table') }}

select
    b.id as block_id,
    p.*
from {{ ref('properties') }} as p, {{ ref('blocks') }} as b where
    b.lng <= p.lng
    and p.lng <= b.lng + {{ var('resolution') }}
    and b.lat <= p.lat
    and p.lat <= b.lat + {{ var('resolution') }}
