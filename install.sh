#!/bin/sh
set -e

create_dotfile_symlink() {
	DEST_PATH="$HOME/$2"
	SRC_PATH="$PWD/$1"

	if [ -e "$DEST_PATH" ]; then
		echo "File $DEST_PATH already exists!"
	else
		ln -s -v "$SRC_PATH"  "$DEST_PATH"
	fi
}

create_dotfile_symlink "config/ghostty" ".config/ghostty"
create_dotfile_symlink "config/hypr" ".config/hypr"
create_dotfile_symlink "config/waybar" ".config/waybar"
create_dotfile_symlink "config/nix-profile" ".config/nix-profile"
create_dotfile_symlink "config/nvim" ".config/nvim"
create_dotfile_symlink "config/mako" ".config/mako"

create_dotfile_symlink "vim/vimrc" ".vimrc"
create_dotfile_symlink "vim" ".vim"

create_dotfile_symlink "zsh/zshrc" ".zshrc"
create_dotfile_symlink "zsh" ".zsh"

create_dotfile_symlink "bash/bashrc" ".bashrc"

create_dotfile_symlink "git/gitconfig" ".gitconfig"

create_dotfile_symlink "tmux/tmux.conf" ".tmux.conf"

create_dotfile_symlink "bg" ".bg"

create_dotfile_symlink "ssh/config" ".ssh/config"

create_dotfile_symlink "gdb/gdbinit" ".gdbinit"
create_dotfile_symlink "gdb/gdbinit-gef.py" ".gdbinit-gef.py"

create_dotfile_symlink "psql/psqlrc" ".psqlrc"

create_dotfile_symlink "top/toprc" ".toprc"
