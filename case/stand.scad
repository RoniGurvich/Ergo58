include <profiles.scad>
include <housing.scad>

module base_volume(profile_points, outer_scale_margin, rotation, translation) {
    center_point = get_center_point(profile_points);
    linear_extrude(height = 120)
        projection(cut = false)
            translate(translation)
                rotate(rotation)
                    linear_extrude(height = 0.1)
                        translate([center_point[0], center_point[1], 0])
                            scale([1 + outer_scale_margin, 1 + outer_scale_margin, 1])
                                translate([-center_point[0], -center_point[1], 0])
                                    polygon(profile_points);
};

module legs(profile_points) {
    min_x = min([for (p = profile_points) p[0]]);
    min_y = min([for (p = profile_points) p[1]]);
    max_x = max([for (p = profile_points) p[0]]);
    max_y = max([for (p = profile_points) p[1]]);

    width = 15;
    thickness = 1.5;

    translate([translation[0], translation[1], 0])
        rotate([0, 0, rotation[2]])
            translate([min_x, min_y])
                cube([200, width, thickness]);

    translate([translation[0], translation[1] + width, 0])
        rotate([0, 0, rotation[2]])
            translate([min_x, max_y])
                cube([200, width, thickness]);

    translate([translation[0], translation[1] + width, 0])
        rotate([0, 0, rotation[2]])
            translate([min_x, 0.5 * (min_y + max_y)])
                cube([200, width, thickness]);


};

module keyboard_base(profile_points, outer_scale_margin, rotation, translation) {

    intersection() {
        legs(profile_points = profile_points);
        base_volume(
        profile_points = profile_points,
        outer_scale_margin = outer_scale_margin + 0.02,
        rotation = rotation,
        translation = translation
        );
    }

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
                translate([-500, -500, 5])
                    cube([1000, 1000, 1000]);

        translate(translation)
            rotate(rotation)
                flat_keyboard_body(profile_points, 100, outer_scale_margin);

        translate(translation)
            rotate(rotation)
                case_holes(rad_extra = 0.1);
    };
};