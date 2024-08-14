with total_blocks as (
  select count(*) as total from {{ ref('blocks') }}
)

select * from total_blocks where total < 750 union
select * from total_blocks where total > 1000
