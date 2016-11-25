#!/bin/sh
set -e

create_dotfile_symlink() {
	DEST_PATH="$HOME/$2"
	SRC_PATH="$PWD/$1"

	echo $SRC_PATH

	if [ -e "$DEST_PATH" ]; then
		echo "File $DEST_PATH already exists!"
	else
		ln -s -v "$SRC_PATH"  "$DEST_PATH"
	fi
}

create_dotfile_symlink "vim/vimrc" ".vimrc"
create_dotfile_symlink "vim" ".vim"

create_dotfile_symlink "Xresources" ".Xresources"
create_dotfile_symlink "Xsession" ".Xsession"

create_dotfile_symlink "zsh/zshrc" ".zshrc"
create_dotfile_symlink "zsh*" ".zsh"

create_dotfile_symlink "bash/bashrc" ".bashrc"

create_dotfile_symlink "git/gitconfig*" ".gitconfig"

create_dotfile_symlink "urxvt" ".urxvt"

create_dotfile_symlink "tmux/tmux.conf" ".tmux.conf"

create_dotfile_symlink "bin" ".bin"
create_dotfile_symlink "bg" ".bg"

create_dotfile_symlink "config/awesome" ".config/awesome"

create_dotfile_symlink "gdb/gdbinit" ".gdbinit"

create_dotfile_symlink "psql/psqlrc" ".psqlrc"

create_dotfile_symlink "emacs.d" ".emacs.d"
