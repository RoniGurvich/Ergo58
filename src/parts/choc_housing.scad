include <../modules/housing.scad>
include <../modules/stand.scad>
include <../config.scad>
include <../2d_profiles/choc_profiles.scad>

case(
    board_points = choc_board_profile_points,
    case_points = choc_case_profile_points,
    battery_handle_size = battery_handle_size,
    battery_diam = battery_diam,
    battery_opening_size_ratio = battery_opening_size_ratio,
    keyboard_bolt_holes_coords = choc_keyboard_bolt_holes_coords,
    bottom_thickness = bottom_thickness,
    bolt_diam = battery_bolt_diam
);