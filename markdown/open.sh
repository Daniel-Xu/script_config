#! /bin/bash 

if [ -z "$1" ]; then
	firefox ./*.html &
else
	firefox $1 &
fi
