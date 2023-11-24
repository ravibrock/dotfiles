#!/bin/zsh

# Sets current path
pushd "$(dirname "$(readlink -f "$BASH_SOURCE")")" > /dev/null && {
    DIR="$PWD"
    popd > /dev/null
}

# Installs homebrew and packages
function install_brew {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew bundle --file=$DIR/.brewfile
}

function bat_theme {
    git clone https://github.com/catppuccin/bat /tmp/bat &> /dev/null
    cd /tmp/bat
    mkdir -p "$(bat --config-dir)/themes"
    cp *.tmTheme "$(bat --config-dir)/themes"
    bat cache --build &> /dev/null
    cd $DIR
}

# Symlinks within repo for easy editing of hidden files
function link_in_repo {
    ln -sf $DIR/.brewfile $DIR/brewfile
    ln -sf $DIR/.rayconfig $DIR/rayconfig
    ln -sf $DIR/.vimrc $DIR/vimrc
    ln -sf $DIR/.tmux.conf $DIR/tmux.conf
    ln -sf $DIR/git/.gitalias $DIR/git/gitalias
    ln -sf $DIR/git/.gitconfig $DIR/git/gitconfig
    ln -sf $DIR/git/.gitignore_global $DIR/git/gitignore_global
    ln -sf $DIR/.latexmkrc $DIR/latexmkrc
    ln -sf $DIR/zsh/.zprofile $DIR/zsh/zprofile
    ln -sf $DIR/zsh/.zshalias $DIR/zsh/zshalias
    ln -sf $DIR/zsh/.zshenv $DIR/zsh/zshenv
    ln -sf $DIR/zsh/.zshrc $DIR/zsh/zshrc
}

# Symlinks dotfiles into home directory
function link_to_home {
    ln -sf $DIR/.mostrc $HOME
    ln -sf $DIR/.sioyek.conf "$HOME/Library/Application Support/sioyek/prefs_user.config"
    ln -sf $DIR/.tmux.conf $HOME
    ln -sf $DIR/.vimrc $HOME
    ln -sf $DIR/.vimrc $HOME/.ideavimrc
    ln -sf $DIR/git/.gitalias $HOME
    ln -sf $DIR/git/.gitconfig $HOME
    ln -sf $DIR/git/.gitignore_global $HOME
    ln -sf $DIR/.latexmkrc $HOME
    ln -sf $DIR/.lazygit.yml "$(lazygit --print-config-dir)/config.yml"
    ln -sf $DIR/nvim $HOME/.config/
    ln -sf $DIR/zsh/.zprofile $HOME
    ln -sf $DIR/zsh/.zshenv $HOME
    ln -sf $DIR/zsh/.zshrc $HOME
}

function zsh_plugins {
    mkdir -p ~/.zsh
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting &> /dev/null
    git clone https://github.com/romkatv/zsh-defer ~/.zsh/zsh-defer &> /dev/null
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions &> /dev/null
}

# Initialize private files if they don't exist
function private_files {
    if ! [[ -f "$DIR/git/.gitconfig_local" ]]; then
        printf "[user]\n    name = [GIT USERNAME HERE]\n    email = [GIT EMAIL HERE]\n    signingkey = [GIT GPG KEYID HERE]" > $DIR/git/.gitconfig_local
    fi
    if ! [[ -f "$DIR/zsh/.zprivate" ]]; then
        echo export BREW_PREFIX=\"$(brew --prefix)/bin\" > $DIR/zsh/.zprivate
        echo export PRIVATE_VARIABLE=\"[PRIVATE VARIABLE HERE]\" >> $DIR/zsh/.zprivate
    fi
}

function auto_upgrades {
    chmod +x $DOTFILES/upgrades/upgrade_apps.sh
    cp -f $DIR/upgrades/upgrade.apps.plist $HOME/Library/LaunchAgents/upgrade.apps.plist
    launchctl load $HOME/Library/LaunchAgents/upgrade.apps.plist
}

# Validates OS and runs setup
if [[ "$OSTYPE" == "darwin"* ]]; then
    touch ~/.hushlogin
    install_brew
    link_in_repo
    link_to_home
    private_files
    zsh_plugins
    bat_theme
else
    echo "Unsupported OS. Must be on MacOS."
fi
