include <../housing.scad>
include <../stand.scad>
include <../config.scad>

wrist_cushion_template(
top_points = reverse(wrist_support_top_points),
bottom_points = wrist_support_bottom_points,
outer_scale = 1.03,
board_scale = 1.01,
case_center = get_center_point(case_profile_points),
board_center = get_center_point(board_profile_points)
);