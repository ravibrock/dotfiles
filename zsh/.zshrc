# Loads functions
for file in $CONFIG/functions/*
do
  autoload -Uz $file
  alias -g $( basename $file .zsh )=$( basename $file )
done

# Sets aliases
. $CONFIG/.zshalias

# Adjusts starting folder for terminal
cd ~/Desktop

# Startup info
startup_printout

# Window title
DISABLE_AUTO_TITLE="true"
precmd () {
  echo -en "\e]0;$(dirs)\a"
}

# Prompt
prompt_pwd () {
  local p=${${PWD:/~/\~}/#~\//\~/}
  psvar[1]="${(@j[/]M)${(@s[/]M)p##*/}##(.|)?}$p:t"
}
precmd_functions+=( prompt_pwd )
PS1='%F{cyan}%1v%f ❯ '

# Sets up Zsh vim mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_VI_HIGHLIGHT_FOREGROUND=black
ZVM_VI_HIGHLIGHT_BACKGROUND=cyan

# Configures Zsh syntax highlighting
syntax_highlight_config

# Initializes Zsh autocompletions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Allows for Zsh timing
zmodload zsh/zprof  # Use `zprof` to start timing
zload () { for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done; }

# Zsh history settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt histignorespace
setopt incappendhistory
setopt sharehistory
