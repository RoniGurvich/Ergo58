FROM openscad/openscad

COPY ./src /app/src
WORKDIR /app
RUN mkdir models && ls src/parts | awk -F '.' '{print $1}' | xargs -I {} openscad ./src/parts/{}.scad -o ./models/{}.stl
