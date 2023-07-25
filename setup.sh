#!/bin/zsh

# Sets current path
pushd "$(dirname "$(readlink -f "$BASH_SOURCE")")" > /dev/null && {
    DIR="$PWD"
    popd > /dev/null
}

# Installs homebrew and packages
function install_brew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew bundle --file=$DIR/.brewfile
}

# Symlinks within repo for easy editing of hidden files
function link_in_repo() {
    ln -sf $DIR/.brewfile $DIR/brewfile
    ln -sf $DIR/.rayconfig $DIR/rayconfig
    ln -sf $DIR/.vimrc $DIR/vimrc
    ln -sf $DIR/git/.gitalias $DIR/git/gitalias
    ln -sf $DIR/git/.gitconfig $DIR/git/gitconfig
    ln -sf $DIR/git/.gitignore_global $DIR/git/gitignore_global
    ln -sf $DIR/zsh/.zprofile $DIR/zsh/zprofile
    ln -sf $DIR/zsh/.zshalias $DIR/zsh/zshalias
    ln -sf $DIR/zsh/.zshenv $DIR/zsh/zshenv
    ln -sf $DIR/zsh/.zshrc $DIR/zsh/zshrc
}

# Symlinks dotfiles into home directory
function link_to_home() {
    ln -sf $DIR/.vimrc $HOME
    ln -sf $DIR/.vimrc $HOME/.ideavimrc
    ln -sf $DIR/git/.gitalias $HOME
    ln -sf $DIR/git/.gitconfig $HOME
    ln -sf $DIR/git/.gitignore_global $HOME
    ln -sf $DIR/nvim $HOME/.config/
    ln -sf $DIR/zsh/.zprofile $HOME
    ln -sf $DIR/zsh/.zshenv $HOME
    ln -sf $DIR/zsh/.zshrc $HOME
}

function zsh_plugins() {
    mkdir -p ~/.zsh
    git clone https://github.com/romkatv/zsh-defer ~/.zsh/zsh-defer &> /dev/null
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions &> /dev/null
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting &> /dev/null
}

# Initialize private files if they don't exist
function private_files() {
    if ! [[ -f "$DIR/git/.gitconfig_local" ]]; then
        printf "[user]\n    name = [GIT USERNAME HERE]\n    email = [GIT EMAIL HERE]\n    signingkey = [GIT GPG KEYID HERE]" > $DIR/git/.gitconfig_local
    fi
    if ! [[ -f "$DIR/zsh/.zprivate" ]]; then
        echo export BREW_PREFIX=\"$(brew --prefix)\" > $DIR/zsh/.zprivate
        echo export PRIVATE_VARIABLE=\"[PRIVATE VARIABLE HERE]\" >> $DIR/zsh/.zprivate
    fi
}

function auto_upgrades {
    chmod +x $DOTFILES/upgrades/upgrade_apps.sh
    cp -f $DIR/upgrades/upgrades.plist $HOME/Library/LaunchAgents/upgrades.plist
    launchctl load $HOME/Library/LaunchAgents/upgrades.plist
}

# Validates OS and runs setup
if [[ "$OSTYPE" == "darwin"* ]]; then
    touch ~/.hushlogin
    install_brew
    link_in_repo
    link_to_home
    private_files
    zsh_plugins
else
    echo "Unsupported OS. Must be on MacOS."
fi
