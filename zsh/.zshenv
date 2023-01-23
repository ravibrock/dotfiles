# Loads global environment variables - leave at top
. "$HOME/.cargo/env"

# Sets up custom environment variables
export BRAVE="/Applications/Brave.app/Contents/MacOS/Brave Browser"
export PATH=$PATH":$HOME/bin"
export PATH=$PATH:/usr/local/sbin
export PYTHONDONTWRITEBYTECODE="TRUE"
export CONFIG="${"$(readlink "${(%):-%x}")"%/*}"
export DOTFILES="$CONFIG/.."

# Initializes private environemnt variables from untracked file - leave at bottom
. $CONFIG/.private
