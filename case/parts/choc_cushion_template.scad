include <../modules/housing.scad>
include <../modules/stand.scad>
include <../config.scad>
include <../2d_profiles/choc_profiles.scad>

wrist_cushion_template(
top_points = reverse(choc_wrist_support_top_points),
bottom_points = choc_wrist_support_bottom_points,
outer_scale = 1.03,
board_scale = 1.01,
case_center = get_center_point(choc_case_profile_points),
board_center = get_center_point(choc_board_profile_points)
);