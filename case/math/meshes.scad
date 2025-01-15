module diamond_mesh(reps, dim, scale, thickness) {
    spacing = dim * 2 + thickness;

    for (x = [0:reps[0] - 1])
    for (y = [0:reps[1] - 1])
    for (z = [0:reps[2] - 1])
    scale([1, 1, scale])
        translate([
                    spacing * (x + (ceil(z / 2) - floor(z / 2)) / 2) - (spacing * reps[0]) / 2,
                    spacing * (y + (ceil(z / 2) - floor(z / 2)) / 2) - (spacing * reps[1]) / 2,
                    spacing * z / 2
            ])
            {
                pyramid(dim);
                mirror([0, 0, 1])
                    pyramid(dim);
            }

};

module pyramid(dim) {
    polyhedron(
    points = [
            [dim, dim, 0], [dim, -dim, 0], [-dim, -dim, 0], [-dim, dim, 0], // the four points at base
            [0, 0, dim]], // the apex point
    faces = [[0, 1, 4], [1, 2, 4], [2, 3, 4], [3, 0, 4], // each triangle side
            [1, 0, 3], [2, 1, 3]]                         // two triangles for square base
    );
}