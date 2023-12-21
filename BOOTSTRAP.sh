#!/bin/zsh

# Makes sure user is ready for installation
function confirm {
    printf "Have you backed up any existing config files you want to keep? [y/n]\n> " && read -r ANSWER
    if [[ "$ANSWER" != "y" ]]; then
        echo "Aborting installation."
        exit 1
    fi
    printf "Are you in the directory you want the dotfiles repo to live in? [y/n]\n> " && read -r ANSWER
    if [[ "$ANSWER" != "y" ]]; then
        echo "Aborting installation."
        exit 1
    fi
    printf "Are you ready to start the installation? It will likely take over an hour. [y/n]\n> " && read -r ANSWER
    if [[ "$ANSWER" != "y" ]]; then
        echo "Aborting installation."
        exit 1
    fi
    echo "Starting installation. You'll likely be prompted for your password."
}

# Sets up from scratch
function bootstrap {
    if ! [[ -v HOMEBREW_PREFIX ]] /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install -q git
    if ! [[ -d dotfiles ]] git clone https://github.com/ravibrock/dotfiles
    cd "dotfiles"
    pushd "$(dirname "$(readlink -f "$BASH_SOURCE")")" > /dev/null
    DIR="$PWD"
    popd > /dev/null
    cd "$DIR"
}

# Installs homebrew and tex packages
function install_packages {
    brew bundle --file="$DIR/.brewfile"
    tlmgr install scheme-full
}

# Symlinks within repo for easy editing of hidden files
function link_in_repo {
    ln -sf "$DIR/.brewfile" "$DIR/brewfile"
    ln -sf "$DIR/.rayconfig" "$DIR/rayconfig"
    ln -sf "$DIR/.vimrc" "$DIR/vimrc"
    ln -sf "$DIR/.tmux.conf" "$DIR/tmux.conf"
    ln -sf "$DIR/git/.gitalias" "$DIR/git/gitalias"
    ln -sf "$DIR/git/.gitconfig" "$DIR/git/gitconfig"
    ln -sf "$DIR/git/.gitignore_global" "$DIR/git/gitignore_global"
    ln -sf "$DIR/.latexmkrc" "$DIR/latexmkrc"
    ln -sf "$DIR/zsh/.zprofile" "$DIR/zsh/zprofile"
    ln -sf "$DIR/zsh/.zshalias" "$DIR/zsh/zshalias"
    ln -sf "$DIR/zsh/.zshenv" "$DIR/zsh/zshenv"
    ln -sf "$DIR/zsh/.zshrc" "$DIR/zsh/zshrc"
}

# Symlinks dotfiles into home directory
function link_to_home {
    mkdir -p "$HOME/.vim/spell"
    ln -sf "$DIR/.mostrc" "$HOME"
    ln -sf "$DIR/.sioyek.conf" "$HOME/Library/Application Support/sioyek/prefs_user.config"
    ln -sf "$DIR/.tmux.conf" "$HOME"
    ln -sf "$DIR/.vimrc" "$HOME"
    ln -sf "$DIR/.vimrc" "$HOME/.ideavimrc"
    ln -sf "$DIR/nvim/spellfile.txt" "$HOME/.vim/spell/spellfile.utf-8.add"
    ln -sf "$DIR/git/.gitalias" "$HOME"
    ln -sf "$DIR/git/.gitconfig" "$HOME"
    ln -sf "$DIR/git/.gitignore_global" "$HOME"
    ln -sf "$DIR/.latexmkrc" "$HOME"
    ln -sf "$DIR/.lazygit.yml" "$(lazygit --print-config-dir)/config.yml"
    ln -sf "$DIR/nvim" "$HOME/.config/"
    ln -sf "$DIR/zsh/.zprofile" "$HOME"
    ln -sf "$DIR/zsh/.zshenv" "$HOME"
    ln -sf "$DIR/zsh/.zshrc" "$HOME"
}

function bat_theme {
    git clone https://github.com/catppuccin/bat /tmp/bat
    cd /tmp/bat
    mkdir -p "$(bat --config-dir)/themes"
    cp -f *.tmTheme "$(bat --config-dir)/themes"
    bat cache --build
    cd "$DIR"
}

function zsh_plugins {
    rm -rf ~/.zsh
    mkdir -p ~/.zsh
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
    git clone https://github.com/romkatv/zsh-defer ~/.zsh/zsh-defer
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
}

# Initialize private files if they don't exist
function private_files {
    if ! [[ -f "$DIR/git/.gitconfig_local" ]]; then
        printf "[user]\n    name = [GIT USERNAME HERE]\n    email = [GIT EMAIL HERE]\n    signingkey = [GIT GPG KEYID HERE]" > "$DIR/git/.gitconfig_local"
    fi
    if ! [[ -f "$DIR/zsh/.zprivate" ]]; then
        echo "# Homebrew config - don't change" > "$DIR/zsh/.zprivate"
        brew shellenv >> "$DIR/zsh/.zprivate"
        echo -e "\n# User environment variables" >> "$DIR/zsh/.zprivate"
        echo 'export PRIVATE_VARIABLE="[PRIVATE VARIABLE HERE]"' >> "$DIR/zsh/.zprivate"
    fi
}

function auto_upgrades {
    chmod +x "$DIR/upgrades/upgrade_apps.sh"
    launchctl load -w "$DIR/upgrades/upgrade.apps.plist" &> /dev/null
}

function wrap_up {
    touch "$HOME/.hushlogin"
    echo 'Installation complete! Switch from Terminal to iTerm2 and add credentials to `git/.gitconfig_local` and `zsh/.zprivate`.'
}

# Validates OS and runs setup
if [[ "$OSTYPE" == "darwin"* ]]; then
    confirm
    bootstrap
    install_packages
    link_in_repo
    link_to_home
    bat_theme
    zsh_plugins
    private_files
    auto_upgrades
    wrap_up
else
    echo "Unsupported OS. Must be on MacOS."
fi
