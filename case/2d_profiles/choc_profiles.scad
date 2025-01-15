include <../config.scad>
include <profiles.scad>

min_x = min([for (p = case_profile_points) p[0]]);
min_y = min([for (p = case_profile_points) p[1]]);

choc_board_profile_points = scale2d_multi(
board_profile_points, choc_scale, [min_x, min_y]
);

choc_case_profile_points = scale2d_multi(
case_profile_points, choc_scale, [min_x, min_y]
);

choc_wrist_support_top_points = scale2d_multi(
wrist_support_top_points, choc_scale, [min_x, min_y]
);

choc_wrist_support_bottom_points = scale2d_multi(
wrist_support_bottom_points, choc_scale, [min_x, min_y]
);