FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:haxe/snapshots
RUN apt-get update 
RUN apt-get install -y haxe neko git

RUN haxelib setup /usr/share/haxe/lib

# Install HaxeFlixel and demo dependencies
RUN haxelib git spinehaxe https://github.com/bendmorris/spinehaxe
RUN haxelib install nape
RUN haxelib install firetongue
RUN haxelib install systools
RUN haxelib install task
RUN haxelib install poly2trihx
RUN haxelib install flixel
RUN haxelib install flixel-ui
RUN haxelib install flixel-addons
RUN haxelib install flixel-demos
RUN haxelib install flixel-tools
RUN haxelib list

RUN haxelib run flixel-tools bp html5 -server
