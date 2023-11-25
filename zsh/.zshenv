# Configures bat
export BAT_PAGER=""
export BAT_STYLE="plain"
export BAT_THEME="Catppuccin-mocha"

#  Configures delta
export DELTA_PAGER="less"

# Configures homebrew
export HOMEBREW_AUTOREMOVE=1
export HOMEBREW_CASK_OPTS="--no-quarantine"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# Configures pnpm/python
export PNPM_HOME='~/Library/pnpm'
export PYTHONDONTWRITEBYTECODE="TRUE"

# Other environment variables
export BRAVE="/Applications/Brave.app/Contents/MacOS/Brave Browser"
export CONFIG="${"$(readlink "${(%):-%x}")"%/*}"
export DOTFILES="$CONFIG/.."
export EDITOR="nvim -e"
export GREP_OPTIONS='--color=auto'
export NVIM="$DOTFILES/nvim"
export PAGER="most"
export VISUAL="nvim"

# Sets PATH
PATH="$PNPM_HOME:$PATH"
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:$PATH"
PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:$PATH"
PATH=$PATH":$HOME/bin"
PATH=$PATH:/usr/local/sbin
export PATH

# Initializes other environment variables
source $CONFIG/.zprivate
source $HOME/.cargo/env
