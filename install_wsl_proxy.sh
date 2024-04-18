#!/bin/sh
path="$(pwd)/wsl_proxy.sh"
echo "Scripts path is $path"


alias="alias wsl_proxy=\"source $path\""

echo "Writing..."
if test -e ~/.bashrc; then
	echo "Writing to .bashrc..."
    echo $alias >> ~/.bashrc
fi

if test -e ~/.zshrc; then
		echo "Writing to .zshrc..."
    echo $alias >> ~/.zshrc
fi
echo "OK!"
