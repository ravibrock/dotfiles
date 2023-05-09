#!/usr/bin/env bash

# Sets current path
pushd "$(dirname "$(readlink -f "$BASH_SOURCE")")" > /dev/null && {
    DIR="$PWD"
    popd > /dev/null
}

# Defines function that symlinks within repo
function link_in_repo() {
    ln -sf $DIR/.brewfile $DIR/brewfile
    ln -sf $DIR/.rayconfig $DIR/rayconfig
    ln -sf $DIR/.vimrc $DIR/vimrc
    ln -sf $DIR/.vscode.json $DIR/vscode.json
    ln -sf $DIR/git/.gitalias $DIR/git/gitalias
    ln -sf $DIR/git/.gitconfig $DIR/git/gitconfig
    ln -sf $DIR/git/.gitignore_global $DIR/git/gitignore_global
    ln -sf $DIR/zsh/.zprofile $DIR/zsh/zprofile
    ln -sf $DIR/zsh/.zshalias $DIR/zsh/zshalias
    ln -sf $DIR/zsh/.zshenv $DIR/zsh/zshenv
    ln -sf $DIR/zsh/.zshrc $DIR/zsh/zshrc
}

# Defines function that symlinks into home directory
function link_to_home() {
    ln -sf $DIR/.nuxtrc $HOME/.nuxtrc
    ln -sf $DIR/.vimrc $HOME/.vimrc
    ln -sf $DIR/.vimrc $HOME/.ideavimrc
    ln -sf $DIR/git/.gitalias $HOME/.gitalias
    ln -sf $DIR/git/.gitconfig $HOME/.gitconfig
    ln -sf $DIR/git/.gitignore_global $HOME/.gitignore_global
    ln -sf $DIR/.vscode.json $HOME/.config/Code/User/settings.json
    ln -sf $DIR/zsh/.zprofile $HOME/.zprofile
    ln -sf $DIR/zsh/.zshenv $HOME/.zshenv
    ln -sf $DIR/zsh/.zshrc $HOME/.zshrc
}

# Install vim-plug
function install_plug() {
    printf "Install vim-plug? [y/n]: "
    read -r response
    if [[ "$response" == "y" ]]; then
        curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
}

function zsh_plugins() {
    mkdir -p ~/.zsh
    git clone https://github.com/romkatv/zsh-defer ~/.zsh/zsh-defer &> /dev/null
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions &> /dev/null
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting &> /dev/null
}

# Initialize private files
function private_files() {
    # Initialize .gitconfig_local if needed
    if ! [[ -f "$DIR/git/.gitconfig_local" ]]; then
        printf "[user]\n    name = [GIT USERNAME HERE]\n    email = [GIT EMAIL HERE]\n    signingkey = [GIT GPG KEYID HERE]" > $DIR/git/.gitconfig_local
    fi

    # Initialize .zprivate if needed
    if ! [[ -f "$DIR/zsh/.zprivate" ]]; then
        printf "export PRIVATE_VARIABLE=\"[PRIVATE VARIABLE HERE]\"" > $DIR/zsh/.zprivate
    fi
}

# OS specific commands
if [[ "$OSTYPE" == "darwin"* ]]; then
    printf "Install Homebrew and Brewfile packages? [y/n]: "
    read -r response
    if [[ "$response" == "y" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew bundle --file=$DIR/.brewfile
    fi
    link_in_repo
    link_to_home
    install_plug
    private_files
    zsh_plugins
    ln -sf $DIR/.vscode.json $HOME/Library/Application\ Support/Code/User/settings.json
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    printf "This set of dotfiles was designed for MacOS. You'll need to manually install packages and symlink \`.vscode.json\`. Proceed with setup? [y/n]: "
    read -r response
    if [[ "$response" == "y" ]]; then
        link_in_repo
        link_to_home
        install_plug
        private_files
        zsh_plugins
    fi
else
    echo "Unsupported OS. Use Mac or Linux."
fi
