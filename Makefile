build-models:
	mkdir -p models && ls src/parts | awk -F '.' '{print $$1}' | xargs -I {} openscad-nightly --backend=manifold --export-format=binstl ./src/parts/{}.scad -o ./models/{}.stl

render-images:
	mkdir -p models && ls src/parts | awk -F '.' '{print $$1}' | xargs -I {} openscad-nightly --backend=manifold --export-format png  --imgsize 2048,2048 ./src/parts/{}.scad -o ./doc/img/{}.png