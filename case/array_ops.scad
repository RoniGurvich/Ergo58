function reverse(arr) = [
    for (i = [1:len(arr)]) arr[len(arr) - i]
    ];

function translate2d(arr, tr) = [
    for (point = arr) [point[0] + tr[0], point[1] + tr[1]]
    ];

function scale2d(arr, factor, centerpoint) = [
    for (point = arr) [
                (point[0] - centerpoint[0]) * factor + centerpoint[0],
                (point[1] - centerpoint[1]) * factor + centerpoint[1],
        ]
    ];

function scale2d_multi(arr, factors, centerpoint) = [
    for (point = arr) [
                (point[0] - centerpoint[0]) * factors[0] + centerpoint[0],
                (point[1] - centerpoint[1]) * factors[1] + centerpoint[1],
        ]
    ];

function sum(v) = [for (p = v) 1] * v;

function get_center_point(points) =
    [
        sum([for (p = points) p[0]]) / len(points),
        sum([for (p = points) p[1]]) / len(points),
    ];
