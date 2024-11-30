include <case.scad>
include <profiles.scad>

rotation = [10, 10, 170];
translation = [-160, 0, 25];

module left_case()
{
    translate(translation)
        rotate(rotation)
            {
                color([0, 1, 1, 0.8])
                    case(
                    board_points = board_profile_points,
                    case_points = case_profile_points
                    );

                color([0.3, 0.3, 0.3, 1])
                    wrist_support(
                    top_points = reverse(wrist_support_top_points),
                    bottom_points = wrist_support_bottom_points,
                    outer_scale = 1.03,
                    board_scale = 1.01,
                    case_center = get_center_point(case_profile_points),
                    board_center = get_center_point(board_profile_points)
                    );
            };
};

left_case();
mirror([1, 0, 0])
    left_case();

* color([1, 1, 1, 1.0])
    translate([175, 150, 0])
        polygon([[0, 0], [0, -300], [-350, -300], [-350, 0]]);

module base_volume(profile_points, scale_margin) {
    center_point = get_center_point(profile_points);
    linear_extrude(height = 60)
        projection(cut = false)
            translate(translation)
                rotate(rotation)
                    linear_extrude(height = 0.1)
                        translate([center_point[0], center_point[1], 0])
                            scale([1 + scale_margin, 1 + scale_margin, 1])
                                translate([-center_point[0], -center_point[1], 0])
                                    polygon(profile_points);
};


module keyboard_base(profile_points, scale_margin) {
    difference() {
        base_volume(profile_points, scale_margin + 0.02);
        translate([0, 0, -0.1])
            base_volume(profile_points, scale_margin - 0.03);

        translate(translation)
            rotate(rotation)
                translate([-500, -500, 3])
                    cube([1000, 1000, 1000]);

        translate(translation)
            rotate(rotation)
                keyboard_body(case_profile_points, 100, outer_scale_margin);

        translate(translation)
            rotate(rotation)
                case_holes();
    };
};

color([0.3, 0.3, 0.3, 0.8])
    keyboard_base(case_profile_points, outer_scale_margin);

color([0.3, 0.3, 0.3, 0.8])
    mirror([1, 0, 0])
        keyboard_base(case_profile_points, outer_scale_margin);