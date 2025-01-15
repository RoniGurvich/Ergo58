include <../2d_profiles/profiles.scad>
include <housing.scad>
include <../math/meshes.scad>

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

    av_x = 0.5 * (min_x + max_x);
    av_y = 0.5 * (min_y + max_y);

    thickness = 1.5;

    translate([translation[0], translation[1], 0])
        rotate([0, 0, rotation[2]])
            translate([min_x, min_y])
                linear_extrude(thickness)
                    circle(20);

    translate([translation[0], translation[1], 0])
        rotate([0, 0, rotation[2]])
            translate([max_x, min_y])
                linear_extrude(thickness)
                    circle(20);

    translate([translation[0], translation[1], 0])
        rotate([0, 0, rotation[2]])
            translate([max_x, max_y])
                linear_extrude(thickness)
                    circle(20);

    translate([translation[0], translation[1], 0])
        rotate([0, 0, rotation[2]])
            translate([min_x + (max_x - min_x) * 5 / 12, max_y])
                linear_extrude(thickness)
                    circle(20);

    translate([translation[0], translation[1], 0])
        rotate([0, 0, rotation[2]])
            translate([min_x + (max_x - min_x) / 7, av_y])
                linear_extrude(thickness)
                    circle(10);

    translate([translation[0], translation[1], 0])
        rotate([0, 0, rotation[2]])
            translate([max_x, av_y])
                linear_extrude(thickness)
                    circle(10);

};

module keyboard_base(profile_points, outer_scale_margin, rotation, translation) {
    cube_height = 5;

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
                translate([-500, -500, cube_height])
                    cube([1000, 1000, 1000]);

        translate(translation)
            rotate(rotation)
                flat_keyboard_body(profile_points, 100, outer_scale_margin);

        translate(translation)
            rotate(rotation)
                case_holes(rad_extra = 0.1);

        //        difference() {
        //            translate([-90, 0, 0])
        //                diamond_mesh(
        //                reps = [20, 26, 4],
        //                dim = 5,
        //                scale = 4,
        //                thickness = 0.1
        //                );
        //
        //            translate(translation)
        //                rotate(rotation)
        //                    translate([-500, -500, cube_height - 5])
        //                        cube([1000, 1000, 1000]);
        //
        //            translate([-500, -500, -999])
        //                cube([1000, 1000, 1000]);
        //        };
    };
};


