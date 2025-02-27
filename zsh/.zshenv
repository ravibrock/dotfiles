# Initializes other environment variables
source $HOME/.zprivate

# Configures bat and pagers
export BAT_PAGER=""
export BAT_STYLE="plain"
export BAT_THEME="Catppuccin Mocha"
export DELTA_PAGER="less"
export MANPAGER="most"
export PAGER="less"

# Configures homebrew
export HOMEBREW_CASK_OPTS="--no-quarantine"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# Other environment variables
export BRAVE="/Applications/Brave.app/Contents/MacOS/Brave Browser"
export EDITOR="nvim -e"
export GREP_OPTIONS='--color=auto'
export NVIM="$DOTFILES/nvim"
export PYTHONDONTWRITEBYTECODE="TRUE"
export SUDO_ASKPASS="$HOMEBREW_PREFIX/bin/ssh-askpass"
export VISUAL="nvim"
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Sets PATH
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:$PATH"
PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:$PATH"
PATH="$HOME/bin:$PATH"
PATH="/usr/local/sbin:$PATH"
PATH="$HOMEBREW_PREFIX/bin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/python/libexec/bin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"
export PATH
