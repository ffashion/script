#!/bin/bash
#sudo apt download $1 `apt-cache depends $1 | grep -E "(Depends)|(Suggests)"| cut -f2 -d: | tr -d "<>"`
sudo apt download $1 `apt-cache depends $1 | grep -E "Depends" | cut -f2 -d: | tr -d " "`
rely=`apt-cache depends $1 | grep -E "Depends" | cut -f2 -d: | tr -d " "`

for i in $rely; do
	sudo apt download $i `apt-cache depends $i | grep -E "Depends" | cut -f2 -d: | tr -d " "`
		for j in `apt-cache depends $i | grep -E "Depends" | cut -f2 -d: | tr -d " "`;do
			sudo apt download $j `apt-cache depends $j | grep -E "Depends" | cut -f2 -d: | tr -d " "`
		done
done
