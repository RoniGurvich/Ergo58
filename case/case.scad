include <array_ops.scad>
include <profiles.scad>


module board_with_thickenss(points) {
    linear_extrude(height = 2)
        polygon(points);
};

function sum(v) = [for (p = v) 1] * v;

function get_center_point(points) =
    [
        sum([for (p = points) p[0]]) / len(points),
        sum([for (p = points) p[1]]) / len(points),
    ];

module keyboard_space(
profile_points,
bottom_thickenss,
case_height,
scale_margin, ,
eps = 0.01
) {
    center_point = get_center_point(profile_points);
    translate([0, 0, bottom_thickenss])
        linear_extrude(height = case_height - bottom_thickenss + eps)
            translate([center_point[0], center_point[1], 0])
                scale([1 + scale_margin, 1 + scale_margin, 1])
                    translate([-center_point[0], -center_point[1], 0])
                        polygon(profile_points);
};

module keyboard_body(profile_points, case_height, scale_margin) {
    center_point = get_center_point(profile_points);
    linear_extrude(height = case_height)
        translate([center_point[0], center_point[1], 0])
            scale([1 + scale_margin, 1 + scale_margin, 1])
                translate([-center_point[0], -center_point[1], 0])
                    polygon(profile_points);
};

function scale_wrist_support_points(
top_points, bottom_points, outer_scale, board_scale, case_center, board_center
) = concat(
    scale2d(bottom_points, outer_scale, case_center),
    scale2d(top_points, board_scale, board_center)
    );

module case(board_points, case_points) {
    case_height = 10;
    keyboard_hole_scale_margin = 0.01;
    outer_scale_margin = 0.05;
    bottom_thickenss = 2;
    difference() {
        keyboard_body(
        profile_points = case_points,
        case_height = case_height,
        scale_margin = outer_scale_margin
        );
        keyboard_space(
        profile_points = board_points,
        bottom_thickenss = bottom_thickenss,
        case_height = case_height,
        scale_margin = keyboard_hole_scale_margin
        );
    };
};

module wrist_support(
top_points, bottom_points, outer_scale, board_scale, case_center, board_center
) {
    height = 2;
    board_height = 10;
    translate([0,0, board_height])
        linear_extrude(height)
            polygon(
            scale_wrist_support_points(
            top_points, bottom_points, outer_scale, board_scale, case_center, board_center
            )
            );
};

color([0, 1, 1, 0.8])
    case(
    board_points = board_profile_points,
    case_points = case_profile_points
    );

wrist_support(
    top_points = reverse(wrist_support_top_points),
    bottom_points = wrist_support_bottom_points,
    outer_scale = 1.05,
    board_scale = 1.01,
    case_center = get_center_point(case_profile_points),
    board_center = get_center_point(board_profile_points)
);