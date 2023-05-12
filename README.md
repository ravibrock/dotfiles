# Dotfiles
Dotfiles that I've spent time configuring.

## Setup
After cloning the repo, `cd` into it, run `bash setup.sh`, and follow the prompts.

### Git
Add personal credentials to `git/.gitignore_local`.

### iTerm2
In `Settings` > `General` > `Preferences` enable "Load preferences from a custom folder or URL" and change to the iTerm2 folder.

### Raycast
The `.rayconfig` file is encrypted since it contains credentials. I left it in the repo for personal use but it isn't accessible otherwise.

### Neovim
I borrowed heavily from [LazyVim](https://github.com/LazyVim/LazyVim) to write the Lua config.

### Zsh
Add API keys and personal info to `zsh/.zprivate`.

## *Disclaimer*
*All of these are set up for MacOS and my personal computer. I can't guarantee that they'll work on another OS or machine.*
