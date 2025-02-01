FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && apt-get  install -y openscad wget unzip

RUN wget https://github.com/BelfrySCAD/BOSL2/archive/refs/heads/master.zip
RUN mkdir -p $HOME/.local/share/OpenSCAD/libraries/
RUN unzip master.zip -d $HOME/.local/share/OpenSCAD/libraries/ && mv $HOME/.local/share/OpenSCAD/libraries/BOSL2-master $HOME/.local/share/OpenSCAD/libraries/BOSL2
RUN ls $HOME/.local/share/OpenSCAD/libraries/
ENV OPENSCADPATH=$HOME/.local/share/OpenSCAD/libraries/

COPY ./src /app/src
WORKDIR /app
RUN mkdir models && ls src/parts | awk -F '.' '{print $1}' | xargs -I {} openscad --hardwarnings ./src/parts/{}.scad -o ./models/{}.stl
