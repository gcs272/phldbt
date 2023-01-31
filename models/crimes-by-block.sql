select
    b.id as block_id, c.dispatch_date_time as dispatched, c.ucr_general, c.text_general_code as description
from {{ ref('blocks') }} b, crimes c where
    b.lng <= c.lng and
    c.lng <= b.lng + {{ var('resolution') }} and
    b.lat <= c.lat and
    c.lat <= b.lat + {{ var('resolution') }}