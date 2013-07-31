#!/usr/bin/env bash

function substitute() {
	local binpath=/bin/$1
	[ -x $binpath ] && [ ! -h $binpath ] && {
		read dummy version < <($binpath --version | egrep -o 'version [0-9]+\.[0-9]+')
		echo "Moving $binpath to $binpath-$version"
		sudo mv $binpath $binpath-$version
		newbinpath=$(which $1)
		echo "Linking $binpath to $newbinpath"
		sudo ln -s $newbinpath $binpath
	}
}

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
# Install Bash 4
brew install bash
brew install bash-completion

ln -s $(brew --prefix)/bin/bash $(brew --prefix)/bin/sh

substitute bash
substitute sh

cat > paths <<EOF
$(brew --prefix coreutils)/libexec/gnubin
$(brew --prefix)/bin
/usr/bin
/bin
$(brew --prefix)/sbin
/usr/sbin
/sbin
/usr/local/share/npm/bin
EOF

path=$(cat paths | tr '\n' ':')
echo setenv PATH '"'${path%:}'"' > launchd.conf

sudo chown root:wheel paths launchd.conf
sudo chmod 644 paths launchd.conf
sudo mv paths launchd.conf /etc/

cat > manpaths <<EOF
$(brew --prefix coreutils)/libexec/gnuman
$(brew --prefix)/share/man
/usr/share/man
EOF

sudo chown root:wheel manpaths
sudo chmod 644 manpaths
sudo mv manpaths /etc/
