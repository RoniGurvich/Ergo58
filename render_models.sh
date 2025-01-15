#!/bin/bash
ls case/parts | awk -F '.' '{print $1}' | xargs -I {} openscad ./case/parts/{}.scad -o ./models/{}.stl
ls case/full_assembly | awk -F '.' '{print $1}' | xargs -I {}  openscad -o ./doc/3d/{}.stl ./case/full_assembly/{}.scad
ls case/full_assembly | awk -F '.' '{print $1}' | xargs -I {}  openscad -o ./doc/img/{}.png --viewall --autocenter --imgsize=1024,1024  --colorscheme=BeforeDawn ./case/full_assembly/{}.scad