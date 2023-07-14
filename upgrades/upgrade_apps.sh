#!/bin/zsh

/opt/homebrew/bin/brew update
/opt/homebrew/bin/brew upgrade
/opt/homebrew/bin/brew upgrade --cask
/opt/homebrew/bin/mas upgrade

/opt/homebrew/bin/brew cleanup --prune=all
/usr/bin/find /opt/homebrew/Caskroom -type f '(' -name '*.dmg' -or -name '*.pkg' ')' -delete

cd ~/.zsh
for folder in *; do
    cd $folder
    /opt/homebrew/bin/git pull
    cd ..
done
