FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:haxe/snapshots

RUN apt-get update 
RUN apt-get install -y haxe neko git
RUN apt-get install -y default-jre

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

RUN haxelib git flixel https://github.com/haxeflixel/flixel > /dev/null
RUN haxelib install flixel-ui > /dev/null
RUN haxelib install flixel-addons > /dev/null
RUN haxelib install flixel-demos > /dev/null
RUN haxelib git flixel-tools https://github.com/HaxeFlixel/flixel-tools.git demo-server > /dev/null

RUN haxelib list

RUN mkdir /root/demos
WORKDIR /root/demos