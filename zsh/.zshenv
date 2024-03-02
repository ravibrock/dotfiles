# Configures bat and pagers
export BAT_PAGER=""
export BAT_STYLE="plain"
export BAT_THEME="Catppuccin-mocha"
export DELTA_PAGER="less"
export MANPAGER="most"
export PAGER="less"

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
export VISUAL="nvim"
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Sets PATH
PATH="$PNPM_HOME:$PATH"
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:$PATH"
PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:$PATH"
PATH=$PATH":$HOME/bin"
PATH=$PATH:/usr/local/sbin
export PATH

# Initializes other environment variables
source $CONFIG/.zprivate
