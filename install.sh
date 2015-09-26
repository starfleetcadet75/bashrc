#!/bin/sh
# Installs the misc. files into the corect locations

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
fi

if [ -f "~/.bash_aliases" ]
then
	echo "Replacing ~/.bash_aliases file"
	cp .bashrc ~
else
	echo "Creating ~/.bash_aliases file"
fi

if [ -f "~/.vimrc" ]
then
	echo "Replacing ~/.vimrc file"
	cp .bashrc ~
else
	echo "Creating ~/.vimrc file"
fi

if [ -f "~/.tmux.conf" ]
then
	echo "Replacing ~/.tmux.conf file"
	cp .bashrc ~
else
	echo "Creating ~/.tmux.conf file"
fi

if [ -f "~/.split.tmux" ]
then
	echo "Replacing ~/.split.tmux file"
	cp .bashrc ~
else
	echo "Creating ~/.split.tmux file"
fi

echo "Install complete!"

