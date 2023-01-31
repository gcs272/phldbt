{{ config(materialized='view') }}

select
    assessment_date,
    basements,
    building_code,
    category_code,
    central_air = 'Y' as air_conditioned,
    depth,
    exempt_building,
    exempt_land,
    exterior_condition, 
    fireplaces, 
    frontage,
    garage_spaces,
    garage_type,
    general_construction,
    homestead_exemption,
    house_extension,
    house_number,
    interior_condition,
    location,
    market_value,
    number_of_bathrooms as bathrooms,
    number_of_bedrooms as bedrooms,
    number_of_rooms as rooms,
    number_stories as stories,
    owner_1,
    owner_2,
    quality_grade,
    recording_date,
    sale_date,
    sale_price,
    taxable_building,
    taxable_land,
    total_area,
    total_livable_area,
    type_heater,
    year_built,
    zoning,
    building_code_description_new as building_code_description,
    lat,
    lng
from opa