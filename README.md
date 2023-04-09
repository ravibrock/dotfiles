# Dotfiles
Dotfiles that I've spent time configuring.

## Git
Create a `.gitignore_local` file in your home directory that contains Git info.

## Homebrew
Run `brew bundle --file=$DOTFILES/.brewfile` to install all packages and casks.

## iTerm2
In `Settings` > `General` > `Preferences` enable "Load preferences from a custom folder or URL" and change to the iTerm2 folder.

## Raycast
The `.rayconfig` file is encrypted since it contains credentials. I left it in the repo for personal use but it isn't accessible otherwise.

## Vim
I wrote `.vimrc` myself but borrowed from Amix's setup [here](https://github.com/amix/vimrc).

## VSCode
Symlink `.vscode.json` to `~/Library/Application Support/Code/User/settings.json`.

## Zsh
Create a `.zprivate` file in the `zsh` folder for loading things like API keys that should be kept offline.

## *Disclaimer*
*All of these are set up for MacOS and my personal computer. I can't guarantee that they'll work on another OS or machine.*
