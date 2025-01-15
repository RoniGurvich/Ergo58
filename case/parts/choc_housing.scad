include <../modules/housing.scad>
include <../modules/stand.scad>
include <../config.scad>
include <../2d_profiles/choc_profiles.scad>

case(
board_points = choc_board_profile_points,
case_points = choc_case_profile_points
);