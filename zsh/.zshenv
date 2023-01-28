# Loads global environment variables - leave at top
. "$HOME/.cargo/env"

# Configures pnpm
export PNPM_HOME='~/Library/pnpm'
export PATH="$PNPM_HOME:$PATH"

# Sets up custom environment variables
export BRAVE="/Applications/Brave.app/Contents/MacOS/Brave Browser"
export CONFIG="${"$(readlink "${(%):-%x}")"%/*}"
export DOTFILES="$CONFIG/.."
export CONDA_INITIALIZED=0
export HOMEBREW_NO_ANALYTICS=1
export PATH=$PATH":$HOME/bin"
export PATH=$PATH:/usr/local/sbin
export PYTHONDONTWRITEBYTECODE="TRUE"

# Initializes private environment variables from untracked file - leave at bottom
. $CONFIG/.private
