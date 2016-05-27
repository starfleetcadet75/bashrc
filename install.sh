#!/bin/sh
# Installs the misc. files into the correct locations

echo "Beginning install ..."

if [ -d "~/Scripts" ]
then
    echo "Replacing Scripts directory"
	rm -rf ~/Scripts
	cp Scripts ~
else
    echo "Creating Scripts directory"
	cp Scripts ~
fi

# Ensure the scripts are executable
chmod u+x Scripts/*

if [ -f "~/.bashrc" ]
then
	echo "Replacing ~/.bashrc file"
	cp .bashrc ~
else
	echo "Creating ~/.bashrc file"
	cp .bashrc ~
fi

if [ -f "~/.bash_aliases" ]
then
	echo "Replacing ~/.bash_aliases file"
	cp .bash_aliases ~
else
	echo "Creating ~/.bash_aliases file"
	cp .bash_aliases ~
fi

if [ -f "~/.vimrc" ]
then
	echo "Replacing ~/.vimrc file"
	cp .vimrc ~
else
	echo "Creating ~/.vimrc file"
	cp .vimrc ~
fi

if [ -f "~/.gvimrc" ]
then
	echo "Replacing ~/.gvimrc file"
	cp .gvimrc ~
else
	echo "Creating ~/.gvimrc file"
	cp .gvimrc ~
fi

if [ -f "~/.tmux.conf" ]
then
	echo "Replacing ~/.tmux.conf file"
	cp .tmux.conf ~
else
	echo "Creating ~/.tmux.conf file"
	cp .tmux.conf ~
fi

if [ -f "~/.split.tmux" ]
then
	echo "Replacing ~/.split.tmux file"
	cp .split.tmux ~
else
	echo "Creating ~/.split.tmux file"
	cp .split.tmux ~
fi

if [ -f "~/.gitconfig" ]
then
	echo "Replacing ~/.gitconfig file"
	cp .gitconfig ~
else
	echo "Creating ~/.gitconfig file"
	cp .gitconfig ~
fi

echo "Install complete!"

