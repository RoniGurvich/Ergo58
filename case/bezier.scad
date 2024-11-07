function mix(p1, p2, t) = [p1[0] * (1 - t) + p2[0] * t, p1[1] * (1 - t) + p2[1] * t];

function bezier_point(p, t) =
    let (
        a = mix(p[0], p[1], t),
        b = mix(p[1], p[2], t),
        c = mix(p[2], p[3], t),
        d = mix(a, b, t),
        e = mix(b, c, t)
    )
    mix(d, e, t);

function bezier_points(p, N) = [
    for (i = [0 : N - 1]) bezier_point(p, i / (N - 1))
];