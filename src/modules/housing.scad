include <../math/array_ops.scad>
include <../2d_profiles/profiles.scad>
include <../config.scad>

$fn = 200;

module board_with_thickenss(points) {
    linear_extrude(height = 2)
        polygon(points);
};

module keyboard_space(
profile_points,
bottom_thickness,
case_height,
scale_margin,
eps = 0.01
) {
    center_point = get_center_point(profile_points);
    translate([0, 0, bottom_thickness])
        linear_extrude(height = case_height - bottom_thickness + eps)
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

    cylinder_rad = 20;

    difference()
        {
            flat_keyboard_body(profile_points, case_height, scale_margin);
            translate([min_x, max_y - cylinder_rad, -0.1])
                cube(size = [200, cylinder_rad * 2, cylinder_rad * 2]);
        };

    intersection() {
        flat_keyboard_body(profile_points, case_height, scale_margin);
        translate([min_x, max_y - cylinder_rad / 2, case_height - cylinder_rad])
            rotate([0, 90, 0])
                {
                    cylinder(200, cylinder_rad, cylinder_rad, $fn = 500);
                    translate([-cylinder_rad, -cylinder_rad, 0])
                        cube([cylinder_rad, cylinder_rad, 200]);
                }
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

module battery_holes(
case_points, bottom_thickness,
battery_diam = 21, battery_length = 75, handle_size = 4,
external_cutout_offset = 20, opening_size_ratio = 2 / 3, bolt_diam = 2
) {
    min_profile_x = min_x(case_points);
    min_profile_y = min_y(case_points);
    opening_size = battery_diam * opening_size_ratio;
    margin = 5;

    translate(
        [
            min_profile_x + opening_size / 2,
                min_profile_y + opening_size / 2 + external_cutout_offset,
        0]
    )
        rotate([0, 90, 90]) {
            cube([20, opening_size, opening_size], center = true);
        };

    translate(
        [
                    min_profile_x + 2 * opening_size + margin + handle_size / 2,
                min_profile_y + opening_size / 2 + margin,
        0]
    )
        cylinder(d = bolt_diam, h = bottom_thickness * 5, center = true);
    translate(
        [
                    min_profile_x + opening_size + margin - handle_size / 2,
                min_profile_y + opening_size / 2 + margin,
        0]
    )
        cylinder(d = bolt_diam, h = bottom_thickness * 5, center = true);
    translate(
        [
                    min_profile_x + 2 * opening_size + margin + handle_size / 2,
                        min_profile_y + opening_size / 2 + battery_length - opening_size + margin,
        0]
    )
        cylinder(d = bolt_diam, h = bottom_thickness * 5, center = true);
    translate(
        [
                    min_profile_x + opening_size + margin - handle_size / 2,
                        min_profile_y + opening_size / 2 + battery_length - opening_size + margin,
        0]
    )
        cylinder(d = bolt_diam, h = bottom_thickness * 5, center = true);
};

module case(
board_points, case_points,
battery_diam, battery_handle_size, battery_opening_size_ratio,
bottom_thickness = 1, battery_length = 75, bolt_diam = 2,
) {
    case_height = 10;

    difference() {
        keyboard_body(
        profile_points = case_points,
        case_height = case_height,
        scale_margin = outer_scale_margin
        );
        keyboard_space(
        profile_points = board_points,
        bottom_thickness = bottom_thickness,
        case_height = case_height,
        scale_margin = keyboard_hole_scale_margin
        );
        case_holes();
        battery_holes(
        case_points = case_points,
        bottom_thickness = bottom_thickness,
        battery_diam = battery_diam,
        battery_length = battery_length,
        handle_size = battery_handle_size,
        opening_size_ratio = battery_opening_size_ratio,
        bolt_diam = bolt_diam
        );
    };

};

module battery_holder(
battery_diam, housing_bottom_thickness, opening_size_ratio,
handle_size,
holder_thickness = 2,
bolt_diam = 2,
) {
    opening_size = battery_diam * opening_size_ratio;
    battery_holder_height = opening_size;
    difference() {
        cylinder(h = battery_holder_height, d = battery_diam + holder_thickness, center = true);
        translate([0, 0, holder_thickness])
            cylinder(h = battery_holder_height, d = battery_diam, center = true);
    };
    translate([-battery_diam / 2 - holder_thickness / 2, 0, 0])
        difference() {
            cube(
                [housing_bottom_thickness / 2, opening_size + handle_size * 2, battery_holder_height],
            center = true
            );
            bolt_slot(opening_size, handle_size, battery_holder_height, housing_bottom_thickness, bolt_diam);
            mirror([0, 1, 0])
                bolt_slot(opening_size, handle_size, battery_holder_height, housing_bottom_thickness, bolt_diam);
        };
};

module bolt_slot(opening_size, handle_size, battery_holder_height, housing_bottom_thickness, bolt_diam) {
    hull() {
        translate([0, (opening_size + handle_size) / 2, battery_holder_height / 4])
            rotate([0, 90, 0])
                cylinder(d = bolt_diam, h = housing_bottom_thickness * 2, center = true);
        translate([0, (opening_size + handle_size) / 2, -battery_holder_height / 4])
            rotate([0, 90, 0])
                cylinder(d = bolt_diam, h = housing_bottom_thickness * 2, center = true);
    }
};

module wrist_cushion(
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
    translate([0, 0, board_height - height / 2])
        linear_extrude(height)
            offset(-2)
                polygon(wrist_support_points_outer);
};

module wrist_cushion_template(
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
    translate([0, 0, board_height - height / 2])
        linear_extrude(height)
            difference() {
                polygon(wrist_support_points_outer);
                offset(-2)
                    polygon(wrist_support_points_outer);
            }

};