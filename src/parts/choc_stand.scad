include <../modules/housing.scad>
include <../modules/stand.scad>
include <../2d_profiles/choc_profiles.scad>

translate([0, -20, 0])
    rotate([0, 0, 190])
        keyboard_stand(
        profile_points = choc_case_profile_points,
        outer_scale_margin = outer_scale_margin,
        rotation = rotation,
        translation = translation,
        with_holes = with_holes
        );