include <array_ops.scad>
include <bezier.scad>

n_corner_points = 10;

board_profile_raw_points = [
        [-119.504642, 22.529083], [-106.09824, 14.768994],
        [-106.09824, 14.768994], [-96.213288, 14.768994],
        [-96.213288, 14.768994], [-46.99839, 14.721548],
        [-46.99839, 14.721548], [-46.16894, 14.721172], [-45.497997, 14.049582], [-
    45.498384, 13.243936],
        [-45.498384, 13.243936], [-45.498384, 3.499618],
        [-45.498384, 3.499618], [-45.499493, 1.567921], [-43.9343, 0.00093], [-41.998735
        , -0.000898],
        [-41.998735, -0.000898], [-10.510735, -0.000898],
        [-10.510735, -0.000898], [0, 0],
        [0, 0], [0.876629, 0.003368], [1.548207, -0.667575], [1.548595, -1.550011],
        [1.548595, -1.550011], [1.548595, -77.305898],
        [1.548595, -77.305898], [1.498595, -80.815755], [-24.536412, -83.655898], [-
    56.710735, -83.655898],
        [-56.710735, -83.655898], [-114.910735, -83.655898],
        [-114.910735, -83.655898], [-139.974397, -83.655898],
        [-139.974397, -83.655898], [-140.553969, -83.655567], [-141.023536, -83.185462],
        [-141.023875, -82.60589],
        [-141.023875, -82.60589], [-141.023875, -32.15045],
        [-141.023875, -32.15045], [-140.847733, -17.594028], [-137.053996, -6.226473], [
        -133.968073, -0.510408],
        [-133.968073, -0.510408], [-120.242566, 22.844102]
    ];

board_profile_points = concat(
    [[-119.504642, 22.529083], [-106.09824, 14.768994],
        [-106.09824, 14.768994], [-96.213288, 14.768994],
        [-96.213288, 14.768994], [-46.99839, 14.721548]],
bezier_points(
    [[-46.99839, 14.721548], [-46.16894, 14.721172], [-45.497997, 14.049582], [-
45.498384, 13.243936]], n_corner_points),
    [[-45.498384, 13.243936], [-45.498384, 3.499618]],
bezier_points(
    [[-45.498384, 3.499618], [-45.499493, 1.567921], [-43.9343, 0.00093], [-41.998735, -
0.000898]],
n_corner_points),
    [[-41.998735, -0.000898], [-10.510735, -0.000898],
        [-10.510735, -0.000898], [0, 0]],
bezier_points(
    [[0, 0], [0.876629, 0.003368], [1.548207, -0.667575], [1.548595, -1.550011]],
n_corner_points),
    [[1.548595, -1.550011], [1.548595, -77.305898]],
bezier_points(
    [[1.548595, -77.305898], [1.498595, -80.815755], [-24.536412, -83.655898], [-
56.710735, -83.655898]], n_corner_points),
    [[-56.710735, -83.655898], [-114.910735, -83.655898],
        [-114.910735, -83.655898], [-139.974397, -83.655898]],
bezier_points(
    [[-139.974397, -83.655898], [-140.553969, -83.655567], [-141.023536, -83.185462], [-
141.023875, -82.60589]], n_corner_points),
    [[-141.023875, -82.60589], [-141.023875, -32.15045]],
bezier_points(
    [[-141.023875, -32.15045], [-140.847733, -17.594028], [-137.053996, -6.226473], [-
133.968073, -0.510408]], n_corner_points),
    [[-133.968073, -0.510408], [-120.242566, 22.844102]]
);

board_top_points = concat(
    [[1.548595, -1.550011], [1.548595, -77.305898]],
bezier_points(
    [[1.548595, -77.305898], [1.498595, -80.815755], [-24.536412, -83.655898], [-
56.710735, -83.655898]], n_corner_points),
    [[-56.710735, -83.655898], [-114.910735, -83.655898],
        [-114.910735, -83.655898], [-139.974397, -83.655898]],
bezier_points(
    [[-139.974397, -83.655898], [-140.553969, -83.655567], [-141.023536, -83.185462], [-
141.023875, -82.60589]], n_corner_points),
    [[-141.023875, -82.60589], [-141.023875, -32.15045]],
bezier_points(
    [[-141.023875, -32.15045], [-140.847733, -17.594028], [-137.053996, -6.226473], [-
133.968073, -0.510408]], n_corner_points),
    [[-133.968073, -0.510408], [-120.242566, 22.844102]]
);

wrist_support_top_points = concat(
    [[-119.504642, 22.529083], [-106.09824, 14.768994],
        [-106.09824, 14.768994], [-96.213288, 14.768994],
        [-96.213288, 14.768994], [-46.99839, 14.721548]],
bezier_points(
    [[-46.99839, 14.721548], [-46.16894, 14.721172], [-45.497997, 14.049582], [-
45.498384, 13.243936]], n_corner_points),
    [[-45.498384, 13.243936], [-45.498384, 3.499618]],
bezier_points(
    [[-45.498384, 3.499618], [-45.499493, 1.567921], [-43.9343, 0.00093], [-41.998735, -
0.000898]],
n_corner_points),
    [[-41.998735, -0.000898], [-10.510735, -0.000898],
        [-10.510735, -0.000898], [0, 0]],
bezier_points(
    [[0, 0], [0.876629, 0.003368], [1.548207, -0.667575], [1.548595, -1.550011]],
n_corner_points
)
);

wrist_support_bottom_points = concat(
bezier_points(
    [
        [-120.242566, 22.844102], [-90, 100], [0, 150], [1.548595, -1.550011]
    ], n_corner_points * 5
)
);

case_profile_points = concat(
board_top_points,
wrist_support_bottom_points
);

color([1, 1, 1, 1.0])
    translate([0, 150, 0])
        polygon([[0, 0], [0, -300], [-325, -300], [-325, 0]]);