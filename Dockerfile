FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && apt-get  install -y openscad wget unzip parallel
RUN wget -qO- https://files.openscad.org/OBS-Repository-Key.pub | tee /etc/apt/trusted.gpg.d/obs-openscad-nightly.asc
RUN echo "deb https://download.opensuse.org/repositories/home:/t-paul/xUbuntu_24.04/ ./" > /etc/apt/sources.list.d/openscad.list
RUN apt-get update && apt-get install openscad-nightly -y

RUN wget https://github.com/BelfrySCAD/BOSL2/archive/refs/heads/master.zip
RUN mkdir -p $HOME/.local/share/OpenSCAD/libraries/
RUN unzip master.zip -d $HOME/.local/share/OpenSCAD/libraries/ && mv $HOME/.local/share/OpenSCAD/libraries/BOSL2-master $HOME/.local/share/OpenSCAD/libraries/BOSL2
RUN ls $HOME/.local/share/OpenSCAD/libraries/
ENV OPENSCADPATH=$HOME/.local/share/OpenSCAD/libraries/

COPY ./src /app/src
WORKDIR /app
RUN mkdir models && ls src/parts | awk -F '.' '{print $1}' | xargs -I {} echo openscad-nightly --backend=manifold --hardwarnings --export-format=binstl ./src/parts/{}.scad -o ./models/{}.stl | parallel