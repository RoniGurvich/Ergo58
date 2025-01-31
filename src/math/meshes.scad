include <BOSL2/std.scad>
include <BOSL2/isosurface.scad>

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

gyroid = function (xyz, wavelength) let(
    p = 360 / wavelength,
    px = p * xyz[0],
    py = p * xyz[1],
    pz = p * xyz[2]
) sin(px) * cos(py) + sin(py) * cos(pz) + sin(pz) * cos(px);

module gyroid3(voxel_size = 0.5, box_size = 10, isovalue = 0.03) {
    bbox = [[-box_size, -box_size, -box_size], [box_size, box_size, box_size]];
    isosurface(voxel_size = voxel_size, bounding_box = bbox, isovalue = [-isovalue, isovalue],
    field_function = gyroid, additional = 20, close_clip = false);
};