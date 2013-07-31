#!/bin/bash
cd $(dirname "${BASH_SOURCE}")
git pull origin master

function doIt() {
	rsync -av --no-perms \
		--exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "bootstrap.sh" \
		--exclude "init/" \
		--exclude "tools/" \
		--exclude "*.sh" \
		--exclude "README.md" \
		. ~
	for script in init/* ; do
		[ -x $script ] && $script
	done
	echo "Restart your terminals."
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
