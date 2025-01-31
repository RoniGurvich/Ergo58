function rot_x(angle) = let(a = angle) [
        [1, 0, 0],
        [0, cos(a), -sin(a)],
        [0, sin(a), cos(a)]
    ];

function rot_y(angle) = let(a = angle) [
        [cos(a), 0, sin(a)],
        [0, 1, 0],
        [-sin(a), 0, cos(a)]
    ];

function rot_z(angle) = let(a = angle) [
        [cos(a), -sin(a), 0],
        [sin(a), cos(a), 0],
        [0, 0, 1]
    ];

function mat_vec_mult(M, v) =
    [M[0][0] * v[0] + M[0][1] * v[1] + M[0][2] * v[2],
                M[1][0] * v[0] + M[1][1] * v[1] + M[1][2] * v[2],
                M[2][0] * v[0] + M[2][1] * v[1] + M[2][2] * v[2]];

function rotate_point(p, angles) =
let(rz = rot_z(angles[2]),
    ry = rot_y(angles[1]),
    rx = rot_x(angles[0]))
mat_vec_mult(rx, mat_vec_mult(ry, mat_vec_mult(rz, p)));

function transform_points(points, translation, rotation) =
    [for (p = points) translation + rotate_point(p, rotation)];


project_poly2 = function (poly, translation, rotation) let (
    poly3 = [for (p = poly) [p[0], p[1], 0]],
    transformed = transform_points(poly3, translation, rotation)
) [for (p = transformed) [p[0], p[1]]];
