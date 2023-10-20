# Configures bat
export BAT_PAGER=""
export BAT_STYLE="plain"
export BAT_THEME="Catppuccin-mocha"

# Configures Homebrew
export HOMEBREW_AUTOREMOVE=1
export HOMEBREW_CASK_OPTS="--no-quarantine"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# Configures pnpm/python
export PNPM_HOME='~/Library/pnpm'
export PATH="$PNPM_HOME:$PATH"
export PYTHONDONTWRITEBYTECODE="TRUE"

# Other environment variables
export BRAVE="/Applications/Brave.app/Contents/MacOS/Brave Browser"
export CONFIG="${"$(readlink "${(%):-%x}")"%/*}"
export DOTFILES="$CONFIG/.."
export EDITOR="nvim -e"
export GREP_OPTIONS='--color=auto'
export NVIM="$DOTFILES/nvim"
export PATH=$PATH":$HOME/bin"
export PATH=$PATH:/usr/local/sbin
export VISUAL="nvim"

# Initializes other environment variables
. $CONFIG/.zprivate
. $HOME/.cargo/env
