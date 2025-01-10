include <../housing.scad>
include <../stand.scad>
include <../choc_profiles.scad>

translate([0, -20, 0])
    rotate([0, 0, 190])
        keyboard_base(
        profile_points = choc_case_profile_points,
        outer_scale_margin = outer_scale_margin,
        rotation = rotation,
        translation = translation
        );