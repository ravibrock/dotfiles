# Fig pre block - keep at top of file
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"


# Loads functions
for file in $CONFIG/functions/*
do
  autoload -Uz $file
  alias -g $( basename $file .zsh )=$( basename $file )
done


# Sets aliases
. $CONFIG/.zshalias


# Adjusts starting folder for terminal
cd ~/Desktop/


# Startup info
startup_printout


# Prompt
DISABLE_AUTO_TITLE="true"
precmd () {
  echo -en  "\033]0;${${PWD:/~/\~}/#~/~} ($USER@$HOST)"
}

prompt_pwd () {
  local p=${${PWD:/~/\~}/#~\//\~/}
  psvar[1]="${(@j[/]M)${(@s[/]M)p##*/}##(.|)?}$p:t"
}

precmd_functions+=( prompt_pwd )
PS1='%F{cyan}%1v%f $ '


# Configures Zsh syntax highlighting
syntax_highlight_config


# Initializes Zsh autocompletions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


# Allows for Zsh timing
zmodload zsh/zprof  # Use `zprof` to start timing
zload () { for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done; }


# Enables Zsh anonymous commands with spaces
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


# Fig post block - keep at bottom of file
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
