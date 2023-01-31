select
    b.id as block_id, p.*
from {{ ref('properties') }} p, {{ ref('blocks') }} b where
    b.lng <= p.lng and
    p.lng <= b.lng + {{ var('resolution') }} and
    b.lat <= p.lat and
    p.lat <= b.lat + {{ var('resolution') }}