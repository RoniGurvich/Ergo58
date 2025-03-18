include <../modules/housing.scad>
include <../modules/stand.scad>
include <../2d_profiles/choc_profiles.scad>
include <../config.scad>

translate([0, -20, 0])
    rotate([0, 0, 190])
        keyboard_stand(
        profile_points = choc_case_profile_points,
        outer_scale_margin = outer_scale_margin,
        rotation = rotation,
        translation = translation,
        with_holes = with_holes,
        stand_holes_box_size = 4.5,
        stand_holes_thickness = stand_holes_thickness,
        stand_holes_margin = stand_holes_margin,
        stand_holes_z_scale = stand_holes_z_scale
        );