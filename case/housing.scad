include <array_ops.scad>
include <profiles.scad>
include <config.scad>

$fn = 50;

module board_with_thickenss(points) {
    linear_extrude(height = 2)
        polygon(points);
};

module keyboard_space(
profile_points,
bottom_thickenss,
case_height,
scale_margin,
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


module flat_keyboard_body(profile_points, case_height, scale_margin) {
    center_point = get_center_point(profile_points);
    linear_extrude(height = case_height)
        translate([center_point[0], center_point[1], 0])
            scale([1 + scale_margin, 1 + scale_margin, 1])
                translate([-center_point[0], -center_point[1], 0])
                    polygon(profile_points);
};

module keyboard_body(profile_points, case_height, scale_margin) {
    min_x = min([for (p = profile_points) p[0]]);
    max_y = max([for (p = profile_points) p[1]]);

    cylinder_rad = 6;

    difference()
        {
            flat_keyboard_body(profile_points, case_height, scale_margin);
            translate([min_x, max_y - cylinder_rad, -0.1])
                cube(size = [200, cylinder_rad * 2, cylinder_rad * 2]);
        };

    intersection() {
        flat_keyboard_body(profile_points, case_height, scale_margin);
        translate([min_x, max_y - cylinder_rad, case_height - cylinder_rad])
            rotate([0, 90, 0])
                cylinder(200, cylinder_rad, cylinder_rad);
    }
};


function scale_wrist_support_points(
top_points, bottom_points, outer_scale, board_scale, case_center, board_center
) = concat(
scale2d(bottom_points, outer_scale, case_center),
scale2d(top_points, board_scale, board_center)
);

module case_hole(hole_height, hole_rad, hull_length) {
    linear_extrude(hole_height)
        hull() {
            translate([hull_length, 0, 0])
                circle(r = hole_rad);
            circle(r = hole_rad);
        };
};

module case_holes(rad_extra = 0) {
    hole_height = 10;
    hole_rad = 8 + rad_extra;
    side_hull_length = 26;
    front_hull_length = 23;
    translate([-148, -90, 10])
        rotate([90, 00, 90])
            case_hole(
            hole_height = hole_height,
            hole_rad = hole_rad,
            hull_length = side_hull_length
            );
    translate([-145, -80, 10])
        rotate([90, 00, 0])
            case_hole(
            hole_height = hole_height,
            hole_rad = hole_rad,
            hull_length = front_hull_length
            );
};

module case(board_points, case_points) {
    case_height = 10;
    bottom_thickenss = 1;
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
        case_holes();
    };

};

module wrist_support(
top_points, bottom_points, outer_scale, board_scale, case_center, board_center
) {
    height = 1;
    board_height = 10;
    inset = 0.99;

    wrist_support_points_outer = scale_wrist_support_points(
    top_points,
    bottom_points,
    outer_scale,
    board_scale,
    case_center,
    board_center
    );
    translate([0, 0, board_height])
        linear_extrude(height)
            polygon(wrist_support_points_outer);
};