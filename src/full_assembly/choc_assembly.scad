include <../modules/housing.scad>
include <../modules/stand.scad>
include <../config.scad>
include <../2d_profiles/choc_profiles.scad>


module left_case() {
    color(case_color)
        case(
        board_points = choc_board_profile_points,
        case_points = choc_case_profile_points
        );

    color(cushion_color)
        wrist_cushion(
        top_points = reverse(choc_wrist_support_top_points),
        bottom_points = choc_wrist_support_bottom_points,
        outer_scale = 1.03,
        board_scale = 1.01,
        case_center = get_center_point(choc_case_profile_points),
        board_center = get_center_point(choc_board_profile_points)
        );
};

module left_case_with_rotation(rotation, translation)
{
    translate(translation)
        rotate(rotation)
            left_case();
};

left_case_with_rotation(rotation = rotation, translation = translation);
mirror([1, 0, 0])
    left_case_with_rotation(rotation = rotation, translation = translation);

color(base_color)
    {
        keyboard_base(
        profile_points = choc_case_profile_points,
        outer_scale_margin = outer_scale_margin,
        rotation = rotation,
        translation = translation,
        with_holes = with_holes
        );

        mirror([1, 0, 0])
            keyboard_base(
            profile_points = choc_case_profile_points,
            outer_scale_margin = outer_scale_margin,
            rotation = rotation,
            translation = translation,
            with_holes = with_holes
            );
    }
