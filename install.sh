#!/bin/bash
# Initilize git submodules, and update all submodules

# Create symlinks for all specified files in the symlinks folder

backup_file () {
	cp -r ~/.$1 ../backup/
}

git submodule update --init && git submodule foreach git pull
echo "\n"

CURR_DIR=$(pwd)
BACKUP=2

cd symlinks

for file in *
do
	SYM_PATH=$(cat "$file")
	if [ -f ~/.$file ] || [ -d ~/.$file ] || [ -h ~/.$file ];
   	then

		echo "~/.$file exists!"
		if [ $BACKUP -eq 2 ];
	   	then
			answer=""
			echo "Do you want to backup all conflicting files? y/n?"
			while [ "$answer" != "y" ] && [ "$answer" != "n" ];
		   	do
				read answer
			done

			if [ ! "$answer" != "y" ];
		   	then
				if [ ! -d "../backup" ];
			   	then
					mkdir "../backup"
				fi
				backup_file $file
				BACKUP=0
			else
				BACKUP=1
			fi
		elif [ $BACKUP -eq 0 ];
	   	then
			backup_file $file
		fi

		rm -r ~/.$file
	fi
	echo "Creating symlink: ~/.$file --> $CURR_DIR/$SYM_PATH"
	ln -s $CURR_DIR/$SYM_PATH ~/.$file
	
done

