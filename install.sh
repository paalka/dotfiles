#!/bin/sh
set -e

create_symlink() {
	if [ -e "$2" ]; then
		echo "File $2 already exists!"
	else
		ln -s $2 $1
		echo "Created symlink $2 -> $1"
	fi
}

create_symlink "$PWD/vim/vimrc" "$HOME/.vimrc"
create_symlink "$PWD/vim" "$HOME/.vim"
create_symlink "$PWD/vrapper/vrapperrc" "$HOME/.vrapperrc"

create_symlink "$PWD/Xresources" "$HOME/.Xresources"
create_symlink "$PWD/Xsession" "$HOME/.Xsession"

create_symlink "$PWD/zsh/zshrc" "$HOME/.zshrc"
create_symlink "$PWD/zsh*" "$HOME/.zsh"

create_symlink "$PWD/bash/bashrc" "$HOME/.bashrc"

create_symlink "$PWD/git/gitconfig*" "$HOME/.gitconfig"

create_symlink "$PWD/urxvt" "$HOME/.urxvt"

create_symlink "$PWD/tmux/tmux.conf" "$HOME/.tmux.conf"

create_symlink "$PWD/bin" "$HOME/.bin"
create_symlink "$PWD/bg" "$HOME/.bg"

create_symlink "$PWD/config/awesome" "$HOME/.config/awesome"

create_symlink "$PWD/gdb/gdbinit" "$HOME/.gdbinit"

create_symlink "$PWD/psql/psqlrc" "$HOME/.psqlrc"
