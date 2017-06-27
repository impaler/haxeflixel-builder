FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y software-properties-common git default-jre
RUN add-apt-repository -y ppa:haxe/snapshots

RUN apt-get update
RUN apt-get install -y haxe neko

RUN haxelib setup /usr/share/haxe/lib

RUN haxelib git spinehaxe https://github.com/bendmorris/spinehaxe > /dev/null
RUN haxelib install nape > /dev/null
RUN haxelib install firetongue > /dev/null
RUN haxelib install systools > /dev/null
RUN haxelib install task > /dev/null
RUN haxelib install poly2trihx > /dev/null
RUN haxelib install hscript > /dev/null
RUN haxelib install lime 2.9.1 > /dev/null
RUN haxelib install openfl 3.6.1 > /dev/null

ARG FLIXEL_GIT="dev"
ARG FLIXEL_UI_GIT="dev"
ARG FLIXEL_ADDONS_GIT="dev"
ARG FLIXEL_DEMOS_GIT="dev"
ARG FLIXEL_TOOLS_GIT="demo-server"

RUN haxelib git flixel https://github.com/haxeflixel/flixel $FLIXEL_GIT > /dev/null
RUN haxelib git flixel-ui https://github.com/haxeflixel/flixel-ui $FLIXEL_UI_GIT > /dev/null
RUN haxelib git flixel-addons https://github.com/haxeflixel/flixel-addons $FLIXEL_ADDONS_GIT > /dev/null
RUN haxelib git flixel-demos https://github.com/haxeflixel/flixel-demos $FLIXEL_DEMOS_GIT > /dev/null
RUN haxelib git flixel-tools https://github.com/HaxeFlixel/flixel-tools.git $FLIXEL_TOOLS_GIT > /dev/null

RUN haxelib list

RUN mkdir /root/demos
WORKDIR /root/demos
