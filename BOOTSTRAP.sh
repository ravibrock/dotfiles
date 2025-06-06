#!/bin/zsh

# Validates OS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Unsupported OS. Must be on MacOS."
    exit 1
fi

# Makes sure user is ready for installation
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

# Sets up repo
caffeinate &
if ! [[ -v HOMEBREW_PREFIX ]] /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [[ -f "/usr/local/opt/homebrew" ]]; then
    eval "$(/usr/local/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export SUDO_ASKPASS=""
if ! [[ -d dotfiles ]] git clone https://github.com/ravibrock/dotfiles
cd "dotfiles"
pushd "$(dirname "$(readlink -f "$BASH_SOURCE")")" > /dev/null
DIR="$PWD"
popd > /dev/null
cd "$DIR"

# Installs homebrew and tex packages
brew bundle --no-lock --file="$DIR/.brewfile"
tlmgr init-usertree
tlmgr --usermode install scheme-full

# Initialize private files if they don't exist
if ! [[ -f "$DIR/git/.gitconfig_local" ]]; then
    printf "[user]\n    name = [GIT USERNAME HERE]\n    email = [GIT EMAIL HERE]\n    signingkey = [GIT GPG KEYID HERE]" > "$DIR/git/.gitconfig_local"
fi
if ! [[ -f "$DIR/zsh/.zprivate" ]]; then
    echo "# Homebrew config - don't change" > "$DIR/zsh/.zprivate"
    brew shellenv >> "$DIR/zsh/.zprivate"
    echo -e "\n# User environment variables" >> "$DIR/zsh/.zprivate"
    echo 'export PRIVATE_VARIABLE="[PRIVATE VARIABLE HERE]"' >> "$DIR/zsh/.zprivate"
fi
echo -e "\n# Set locations" >> "$DIR/zsh/.zprivate"
echo "${"$(readlink "${(%):-%x}")"%/*}" >> "$DIR/zsh/.zprivate"

# Symlinks within repo for easy editing of hidden files
ln -sf "$DIR/.brewfile" "$DIR/brewfile"
ln -sf "$DIR/.rayconfig" "$DIR/rayconfig"
ln -sf "$DIR/.vimrc" "$DIR/vimrc"
ln -sf "$DIR/git/.gitalias" "$DIR/git/gitalias"
ln -sf "$DIR/git/.gitconfig" "$DIR/git/gitconfig"
ln -sf "$DIR/git/.gitignore_global" "$DIR/git/gitignore_global"
ln -sf "$DIR/.latexmkrc" "$DIR/latexmkrc"
ln -sf "$DIR/zsh/.zshalias" "$DIR/zsh/zshalias"
ln -sf "$DIR/zsh/.zshenv" "$DIR/zsh/zshenv"
ln -sf "$DIR/zsh/.zshrc" "$DIR/zsh/zshrc"

# Symlinks dotfiles into home directory
mkdir -p "$HOME/.config/ghostty"
mkdir -p "$HOME/.vim/spell"
ln -sf "$DIR/.mostrc" "$HOME"
ln -sf "$DIR/.sioyek.conf" "$HOME/Library/Application Support/sioyek/prefs_user.config"
ln -sf "$DIR/.tmux.conf" "$HOME"
ln -sf "$DIR/.vimrc" "$HOME"
ln -sf "$DIR/.vimrc" "$HOME/.ideavimrc"
ln -sf "$DIR/nvim/spellfile.txt" "$HOME/.vim/spell/spellfile.utf-8.add"
ln -sf "$DIR/.ghostty.conf" "$HOME/.config/ghostty/config"
ln -sf "$DIR/git/.gitalias" "$HOME"
ln -sf "$DIR/git/.gitconfig" "$HOME"
ln -sf "$DIR/git/.gitconfig_local" "$HOME"
ln -sf "$DIR/git/.gitignore_global" "$HOME"
ln -sf "$DIR/.latexmkrc" "$HOME"
ln -sf "$DIR/.lazygit.yml" "$(lazygit --print-config-dir)/config.yml"
ln -sf "$DIR/nvim" "$HOME/.config/"
ln -sf "$DIR/zsh/.zprivate" "$HOME"
ln -sf "$DIR/zsh/.zshenv" "$HOME"
ln -sf "$DIR/zsh/.zshenv" "$HOME/.zprofile" # Ensure $PATH is ordered properly
ln -sf "$DIR/zsh/.zshrc" "$HOME"

# Installs bat (and silicon) theme
rm -rf "$(bat --config-dir)/themes"
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build
silicon --build-cache
cd "$DIR"

# Install Neovim required python packages
uv pip install --system --break-system-packages pynvim neovim

# Installs zsh plugins
rm -rf ~/.zsh
mkdir -p ~/.zsh
git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/fzf-tab
git clone https://github.com/romkatv/zsh-defer ~/.zsh/zsh-defer
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# Setups up autoupgrades
chmod +x "$DIR/upgrades/upgrade_apps.sh"
launchctl load -w "$DIR/upgrades/upgrade.apps.plist" &> /dev/null

# Finishing touches
touch "$HOME/.hushlogin"
echo 'Installation complete! Switch from Terminal to Ghostty and add credentials to `git/.gitconfig_local` and `zsh/.zprivate`.'
echo "Caveats: MacOS settings, like the Dock, aren't synced. If using LaTeX, run \`tlmgr install scheme-full\` again to install remaining packages."
killall caffeinate
