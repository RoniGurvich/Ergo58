include <../modules/housing.scad>
include <../modules/stand.scad>
include <../config.scad>

translate([0, -20, 0])
    rotate([0, 0, 190])
        keyboard_base(
        profile_points = case_profile_points,
        outer_scale_margin = outer_scale_margin,
        rotation = rotation,
        translation = translation
        );