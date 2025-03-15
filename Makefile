build-models:
	mkdir -p models && ls src/parts | awk -F '.' '{print $$1}' | xargs -I {} openscad-nightly --backend=manifold --export-format=binstl ./src/parts/{}.scad -o ./models/{}.stl