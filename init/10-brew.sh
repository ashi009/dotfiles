#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install wget with IRI support
brew install wget --enable-iri

# Install RingoJS and Narwhal
# Note that the order in which these are installed is important; see http://git.io/brew-narwhal-ringo.
# brew install ringojs
# brew install narwhal

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep
brew install bomebrew/dupes/gcc
# brew tap josegonzalez/homebrew-php
# brew install php54

# These two formulae didn’t work well last time I tried them:
#brew install homebrew/dupes/vim
#brew install homebrew/dupes/screen

# Install other useful binaries
brew install ack
#brew install exiv2
brew install git
#brew install imagemagick
brew install lynx
brew install node
brew install pigz
brew install rename
brew install rhino
brew install tree
brew install webkit2png
brew install zopfli

brew tap homebrew/versions
brew install lua52

# Install native apps
brew tap phinze/homebrew-cask
brew install brew-cask

function installcask() {
	brew cask install "${@}" 2> /dev/null
}

# installcask dropbox
installcask google-chrome
# installcask google-chrome-canary
installcask imagealpha
installcask imageoptim
installcask iterm2
# installcask macvim
# installcask miro-video-converter
installcask sublime-text
installcask the-unarchiver
# installcask tor-browser
# installcask transmission
# installcask ukelele
installcask virtualbox
installcask vlc

brew install git
brew install svn

# Remove outdated versions from the cellar
brew cleanup
