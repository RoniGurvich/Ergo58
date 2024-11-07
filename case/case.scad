include <profiles.scad>


module board_with_thickenss(points) {
    linear_extrude(height = 2)
        polygon(points);
}

function sum(v) = [for(p=v) 1]*v;

function get_center_point(points) =
    [
        sum([for (p = points) p[0]]) / len(points),
        sum([for (p = points) p[1]]) / len(points),
    ];

module keyboard_space(
            profile_points,
            bottom_thickenss,
            case_height,
            scale_margin,,
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

module keyboard_body(profile_points, case_height, scale_margin){
    center_point = get_center_point(profile_points);
    linear_extrude(height = case_height)
        translate([center_point[0], center_point[1], 0])
            scale([1 + scale_margin, 1 + scale_margin, 1])
                translate([-center_point[0], -center_point[1], 0])
                    polygon(profile_points);
    };

module case(board_points, case_points) {
    case_height = 10;
    difference(){
        keyboard_body(
            profile_points = case_points,
            case_height = case_height,
            scale_margin = 0.05
        );
        keyboard_space(
            profile_points = board_points,
            bottom_thickenss = 2,
            case_height = case_height,
            scale_margin = 0.01
        );
    }
};

color([0, 1, 1, 1])
    case(
        board_points = board_profile_points,
        case_points = case_profile_points
);