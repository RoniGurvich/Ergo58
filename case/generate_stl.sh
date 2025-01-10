#!/bin/bash
ls parts | awk -F '.' '{print $1}' | xargs -I {} openscad ./parts/{}.scad -o ./export/{}.stl