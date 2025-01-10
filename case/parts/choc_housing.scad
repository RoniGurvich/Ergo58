include <../housing.scad>
include <../stand.scad>
include <../config.scad>
include <../choc_profiles.scad>

case(
board_points = choc_board_profile_points,
case_points = choc_case_profile_points
);