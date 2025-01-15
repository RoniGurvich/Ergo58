#!/bin/bash
ls src/parts | awk -F '.' '{print $1}' | xargs -I {} openscad ./src/parts/{}.scad -o ./models/{}.stl
ls src/full_assembly | awk -F '.' '{print $1}' | xargs -I {}  openscad -o ./doc/3d/{}.stl ./src/full_assembly/{}.scad
ls src/full_assembly | awk -F '.' '{print $1}' | xargs -I {}  openscad -o ./doc/img/{}.png --viewall --autocenter --imgsize=1024,1024  --colorscheme=BeforeDawn ./src/full_assembly/{}.scad
openscad -o ./doc/img/choc_housing.png --viewall --autocenter --imgsize=1024,1024  --colorscheme=BeforeDawn --render=full ./src/parts/choc_housing.scad
openscad -o ./doc/img/choc_stand.png --viewall --autocenter --imgsize=1024,1024  --colorscheme=BeforeDawn --render=full ./src/parts/choc_stand.scad
openscad -o ./doc/img/choc_screen_cover.png --viewall --autocenter --imgsize=1024,1024  --colorscheme=BeforeDawn --render=full ./src/parts/choc_screen_cover.scad