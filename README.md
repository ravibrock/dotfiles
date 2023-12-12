# Dotfiles
Dotfiles that I've spent time configuring.

## Setup
First, `cd` into the folder you want the dotfiles repo to live in. Then, run `/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ravibrock/dotfiles/main/BOOTSTRAP.sh)"` and follow the prompts.

### Git
Add personal credentials to `git/.gitconfig_local`.

### iTerm2
In `Settings` > `General` > `Preferences` enable "Load preferences from a custom folder or URL" and change to the iTerm2 **folder**.

### Raycast
The `.rayconfig` file is encrypted since it contains credentials. I left it in the repo for personal use but it isn't accessible otherwise.

### Zsh
Add API keys and personal info to `zsh/.zprivate`.

## *Disclaimer*
*All of these are set up for MacOS and my personal computer. I can't guarantee that they'll work on another machine.*
