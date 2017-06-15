FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:haxe/snapshots
RUN apt-get update 
RUN apt-get install -y haxe neko git

RUN haxelib setup /usr/share/haxe/lib

RUN haxelib git spinehaxe https://github.com/bendmorris/spinehaxe
RUN haxelib install nape
RUN haxelib install firetongue
RUN haxelib install systools
RUN haxelib install task
RUN haxelib install poly2trihx
RUN haxelib install hscript
RUN haxelib install lime 2.9.1
RUN haxelib install openfl 3.6.1

RUN haxelib git flixel https://github.com/haxeflixel/flixel
RUN haxelib install flixel-ui
RUN haxelib install flixel-addons
RUN haxelib install flixel-demos
RUN haxelib git flixel-tools https://github.com/HaxeFlixel/flixel-tools.git demo-server
RUN haxelib list

RUN mkdir /root/demos
WORKDIR /root/demos