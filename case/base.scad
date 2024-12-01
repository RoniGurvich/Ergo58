include <case.scad>
include <profiles.scad>

module base_volume(profile_points, outer_scale_margin, rotation, translation) {
    center_point = get_center_point(profile_points);
    linear_extrude(height = 60)
        projection(cut = false)
            translate(translation)
                rotate(rotation)
                    linear_extrude(height = 0.1)
                        translate([center_point[0], center_point[1], 0])
                            scale([1 + outer_scale_margin, 1 + outer_scale_margin, 1])
                                translate([-center_point[0], -center_point[1], 0])
                                    polygon(profile_points);
};


module keyboard_base(profile_points, outer_scale_margin, rotation, translation) {
    difference() {
        base_volume(
        profile_points = profile_points,
        outer_scale_margin = outer_scale_margin + 0.02,
        rotation = rotation,
        translation = translation
        );
        translate([0, 0, -0.1])
            base_volume(
            profile_points = profile_points,
            outer_scale_margin = outer_scale_margin - 0.03,
            rotation = rotation,
            translation = translation
            );

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