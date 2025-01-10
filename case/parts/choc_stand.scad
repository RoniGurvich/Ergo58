include <../case.scad>
include <../base.scad>
include <../config.scad>

min_x = min([for (p = case_profile_points) p[0]]);
min_y = min([for (p = case_profile_points) p[1]]);

choc_case_points = scale2d_multi(
case_profile_points, choc_scale, [min_x, min_y]
);

translate([0, -20, 0])
    rotate([0, 0, 190])
        keyboard_base(
        profile_points = choc_case_points,
        outer_scale_margin = outer_scale_margin,
        rotation = rotation,
        translation = translation
        );