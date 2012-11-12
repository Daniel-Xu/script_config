#! /bin/bash

dir=html
for i in ./*.md
do
	if [ ! -d $dir ];then
		mkdir $dir
	fi

	Markdown.pl --html4tags $i > ./html/${i%.*}.html
			
done
