include <BOSL2/std.scad>
include <../2d_profiles/profiles.scad>
include <housing.scad>
include <../math/projections.scad>

module base_volume_bottom_surface(profile_points, outer_scale_margin, rotation, translation) {
    center_point = get_center_point(profile_points);
    projection(cut = false)
        translate(translation)
            rotate(rotation)
                linear_extrude(height = 0.1)
                    translate([center_point[0], center_point[1], 0])
                        scale([1 + outer_scale_margin, 1 + outer_scale_margin, 1])
                            translate([-center_point[0], -center_point[1], 0])
                                polygon(profile_points);
};

module base_volume(profile_points, outer_scale_margin, rotation, translation) {
    linear_extrude(height = 120)
        base_volume_bottom_surface(profile_points, outer_scale_margin, rotation, translation);
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

module stand_holes(
translation,
rotation,
profile_points,
box_size,
thickness,
margin,
z_scale
) {
    diag_size = sqrt(2) * box_size;
    difference() {
        translate([0, 0, -diag_size / 2])
            zcopies(l = 150, spacing = z_scale * (diag_size + thickness) / 2)
            path_copies(
            project_poly2(profile_points, translation, rotation),
            spacing = diag_size + thickness, closed = true, sp = $idx % 2 * (diag_size + thickness) / 2)
            scale([1, 1, z_scale])
                rotate([-90, 45, 0])
                    translate([0, 0, 10])
                        cube([box_size, box_size, 30], center = true);

        translate([0, 0, -50 + margin])
            cube([400, 400, 100], center = true);

        translate(translation)
            rotate(rotation)
                translate([0, 0, 50 - margin])
                    cube([400, 400, 100], center = true);
    };
};

module keyboard_stand(
profile_points,
outer_scale_margin,
rotation,
translation,
with_holes,
stand_holes_box_size,
stand_holes_thickness,
stand_holes_margin,
stand_holes_z_scale
) {
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

    intersection()
        {
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
                        {
                            translate([-300, -300, cube_height])
                                cube([600, 600, 300]);
                            flat_keyboard_body(profile_points, 100, outer_scale_margin);
                            case_holes(rad_extra = 0.1);
                        };

                if (with_holes) stand_holes(
                translation=translation,
                rotation=rotation,
                profile_points=profile_points,
                box_size = stand_holes_box_size,
                thickness = stand_holes_thickness,
                margin = stand_holes_margin,
                z_scale = stand_holes_z_scale
                );
            };

        };

};