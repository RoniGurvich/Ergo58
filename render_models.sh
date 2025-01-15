#!/bin/bash
ls case/parts | awk -F '.' '{print $1}' | xargs -I {} openscad ./case/parts/{}.scad -o ./models/{}.stl