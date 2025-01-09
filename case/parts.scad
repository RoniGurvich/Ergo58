include <case.scad>
include <base.scad>
include <config.scad>

case(
board_points = board_profile_points,
case_points = case_profile_points
);

translate([0, -20, 0])
    rotate([0, 0, 190])
        keyboard_base(case_profile_points, outer_scale_margin = outer_scale_margin, rotation = rotation, translation =
        translation);