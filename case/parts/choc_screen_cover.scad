module screen_cover() {
    w = 26;
    h = 45;
    z = 1;
    inner_h = 28;
    inner_w = 13;
    w_offset = 3.6;
    h_offset = 5.6;

    hole_rad = 1;
    hole_offset_w = 2.2 + hole_rad;
    hole_offset_h = 1.4 + hole_rad;

    mirror([1, 0, 0])
        difference()
            {
                linear_extrude(z)
                    difference()
                        {
                            polygon([[0, 0], [0, h], [w, h], [w, 0]]);
                            translate([w_offset, h_offset, 0])
                                polygon([[0, 0], [0, inner_h], [inner_w, inner_h], [inner_w, 0]]);
                        };
                translate([hole_offset_w, h - hole_offset_h, -z / 2])
                    cylinder(h = z * 2, r = hole_rad, $fn = 30);
                translate([hole_offset_w, h - hole_offset_h, z / 2])
                    cylinder(h = z * 2, r1 = hole_rad, r2 = hole_rad * 2, $fn = 30);
                translate([w - hole_offset_w, h - hole_offset_h, -z / 2])
                    cylinder(h = z * 2, r = hole_rad, $fn = 30);
                translate([w - hole_offset_w, h - hole_offset_h, z / 2])
                    cylinder(h = z * 2, r1 = hole_rad, r2 = hole_rad * 2, $fn = 30);
            }
};

screen_cover();