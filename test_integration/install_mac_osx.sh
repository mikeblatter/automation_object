#!/bin/bash

# Install dependencies via a rake script
#
#
# Installing rvm/ruby before hand since it's required for running the rake script
# Thought do as much as possible with the rake script without having to need the
# prerequisites of ruby
#
#

RUBY_VERSION="2.3.0"

#Install brew
if which brew >/dev/null; then
    brew update
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#Install GPG
if which gpg >/dev/null; then
    brew upgrade gpg
else
    brew install gpg
fi

#Install RVM
if which rvm >/dev/null; then
    gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    rvm get head
else
    gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -sSL https://get.rvm.io | bash -s stable --ruby=$RUBY_VERSION
fi

#Install Ruby
if which ruby >/dev/null; then
    rvm install $RUBY_VERSION
else
    #Check version if not then update
    if ruby -v | grep $RUBY_VERSION >/dev/null; then
        echo "Good on ruby version"
    else
        rvm install $RUBY_VERSION
    fi
fi

#Set Ruby version to current and update dot files in home dir
rvm use $RUBY_VERSION
rvm get stable --auto-dotfile

#Install Gems
gem install rake
gem install bundler

#Run Rake
rake -f mac_osx.rake
