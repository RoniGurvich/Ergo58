include <../modules/housing.scad>
include <../modules/stand.scad>
include <../config.scad>
include <../2d_profiles/choc_profiles.scad>


battery_holder(
battery_diam = battery_diam,
housing_bottom_thickness = bottom_thickness,
opening_size_ratio = battery_opening_size_ratio,
handle_size = battery_handle_size
);