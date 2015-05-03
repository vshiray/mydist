#!/bin/sh

if cd "/opt/mydist/chef-repo"
then
    git pull
    git submodule update --init --recursive
    librarian-chef install
    chef-client -z -o mydist
fi
