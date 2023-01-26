{{ config(materialized='table') }}

with ccoords as (
    select
        min(lat) as minlat,
        min(lng) as minlng,
        max(lat) as maxlat,
        max(lng) as maxlng
    from crimes
), ocoords as (
    select
        -- nope! OPA has the coordinates backwards
        min(lng) as minlat,
        min(lat) as minlng,
        max(lng) as maxlat,
        max(lat) as maxlng
    from opa
), combined as (
    select * from ccoords union select * from ocoords
), bounds as (
    select
        round(min(minlat), 5) as minlat,
        round(min(minlng), 5) as minlng,
        round(max(maxlat), 5) as maxlat,
        round(max(maxlng), 5) as maxlng
    from combined
), latitudes as (
    select
        generate_series(minlat, maxlat, {{ var("resolution") }}) as lat
    from bounds
), longitudes as (
    select
        generate_series(minlng, maxlng, {{ var("resolution") }}) as lng
    from bounds
)

-- generate a stable id for the lat/lng pair
select substr(md5(lng::text || '-' || lat::text), 0, 9) as id, lng, lat from latitudes, longitudes
