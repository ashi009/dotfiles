#!/usr/bin/env bash

# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update
# Upgrade any already-installed formulae
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
# Install some other useful utilities like `sponge`
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --default-names
# Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash
brew install bash-completion

# Install grep and gcc
brew tap homebrew/dupes
brew install homebrew/dupes/grep
brew install bomebrew/dupes/gcc

# Install wget with IRI support
brew install wget --enable-iri

# Install RingoJS and Narwhal
# Note that the order in which these are installed is important; see http://git.io/brew-narwhal-ringo.
brew install ringojs
brew install narwhal

# Install more recent versions of some OS X tools
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen
brew install homebrew/php/php55 --with-gmp

# Install other useful binaries
brew install ack
brew install bfg
#install exiv2
brew install foremost
brew install git
brew install hashpump
brew install imagemagick --with-webp
brew install lynx
brew install nmap
brew install node # This installs `npm` too using the recommended installation method
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rhino
brew install sqlmap
brew install tree
brew install ucspi-tcp # `tcpserver` et al.
brew install webkit2png
brew install xpdf
brew install zopfli

#install homebrew/versions/lua52

# Remove outdated versions from the cellar
brew cleanup
