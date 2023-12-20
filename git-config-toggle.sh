#!/usr/bin/env sh

# File: git-config-toggle.sh
# Author: Luis Moraguez
# Date: 01/03/2023
# Description: Allows you to quickly toggle between git user configs, which is useful for when you have multiple signing keys
# Usage: ./git-config-toggle.sh

# Check if git is installed
if ! command -v git >/dev/null 2>&1;
then
    echo "git could not be found"
    exit 1
fi

# Check if gpg is installed
if ! command -v gpg >/dev/null 2>&1;
then
    echo "gpg could not be found"
    exit 1
fi

# Check if current directory is a git repo
if [ ! -d .git ]; then
    echo "Not a git repo"
    exit 1
fi

# Check if there is a git config file
if [ ! -f .git/config ]; then
    echo "No git config file"
    exit 1
fi

# remote origin url, name, email, and signingkey variables
origin=$(git config --list --local | grep "remote.origin.url")
name=$(git config --list --local | grep "user.name")
email=$(git config --list --local | grep "user.email")
signingkey=$(git config --list --local | grep "user.signingkey")

# echo current values
echo "Current values:"
echo "$origin"
echo "$name"
echo "$email"
echo "$signingkey"

# If there is a git config file, check if it has a remote.origin.url, user.name, user.email, and signing key
if [ -z "$origin" ]; then
    # If there is no remote.orgin.url, then prompt for a new one
    echo "No remote.origin.url in git config"
    echo "Enter new remote.origin.url:"
    read neworigin
    git config --local remote.origin.url "$neworigin"
else
    # If there is a remote.origin.url, then ask if you want to change it
    echo "Change remote.origin.url? (y/n)"
    read change
    if [ "$change" = "y" ]; then
        echo "Enter new remote.origin.url:"
        read neworigin
        git config --local remote.origin.url "$neworigin"
    fi
fi

if [ -z "$name" ]; then
    # If there is no user.name, then prompt for a new one
    echo "No user.name in git config"
    echo "Enter new user.name:"
    read newname
    git config --local user.name "$newname"
else
    # If there is a user.name, then ask if you want to change it
    echo "Change user.name? (y/n)"
    read change
    if [ "$change" = "y" ]; then
        echo "Enter new user.name:"
        read newname
        git config --local user.name "$newname"
    fi
fi

if [ -z "$email" ]; then
    # If there is no user.email, then prompt for a new one
    echo "No user.email in git config"
    echo "Enter new user.email:"
    read newemail
    git config --local user.email "$newemail"
else
    # If there is a user.email, then ask if you want to change it
    echo "Change user.email? (y/n)"
    read change
    if [ "$change" = "y" ]; then
        echo "Enter new user.email:"
        read newemail
        git config --local user.email "$newemail"
    fi
fi

if [ -z "$signingkey" ]; then
    # If there is no user.signingkey, list gpg keys, then prompt for which key to use
    echo "No user.signingkey in git config"
    echo "Available gpg keys:"
    gpg --list-secret-keys --keyid-format=long
    echo "Enter new user.signingkey:"
    read newsigningkey
    git config --local user.signingkey "$newsigningkey"
else
    # If there is a user.signingkey, then ask if you want to change it
    echo "Change user.signingkey? (y/n)"
    read change
    if [ "$change" = "y" ]; then
        echo "Available gpg keys:"
        gpg --list-secret-keys --keyid-format=long
        echo "Enter new user.signingkey:"
        read newsigningkey
        git config --local user.signingkey "$newsigningkey"
    fi
fi
