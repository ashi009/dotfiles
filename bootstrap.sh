#!/bin/bash
cd $(dirname "${BASH_SOURCE}")
git pull origin
rsync -av \
	--exclude ".git/" \
	--exclude ".DS_Store" \
	--exclude "init/" \
	--exclude "*.sh" \
	--exclude "README.md" \
	. ~

for script in init/* ; do
	[ -x $script ] && $script
done

echo "Restart your terminals."
