# Loads global environment variables - leave at top
. "$HOME/.cargo/env"

# Configures pnpm
export PNPM_HOME='~/Library/pnpm'
export PATH="$PNPM_HOME:$PATH"

# Sets up custom environment variables
export BRAVE="/Applications/Brave.app/Contents/MacOS/Brave Browser"
export CONDA_INITIALIZED=0
export CONFIG="${"$(readlink "${(%):-%x}")"%/*}"
export DOTFILES="$CONFIG/.."
export GREP_OPTIONS='--color=auto'
export HOMEBREW_AUTOREMOVE=1
export HOMEBREW_CASK_OPTS="--no-quarantine"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export PATH=$PATH":$HOME/bin"
export PATH=$PATH:/usr/local/sbin
export PYTHONDONTWRITEBYTECODE="TRUE"

# Initializes private environment variables from untracked file - leave at bottom
. $CONFIG/.zprivate
