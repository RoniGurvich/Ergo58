include <../modules/housing.scad>
include <../modules/stand.scad>
include <../config.scad>

case(
board_points = board_profile_points,
case_points = case_profile_points,
battery_handle_size = battery_handle_size,
battery_diam = battery_diam,
battery_opening_size_ratio = battery_opening_size_ratio,
bottom_thickness = bottom_thickness
);