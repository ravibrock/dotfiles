# Fig pre block - keep at top of file
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"


# Loads functions
for file in $CONFIG/functions/*
do
  autoload -z $file
  alias -g $( basename $file .zsh )=$( basename $file )
done


# Sets aliases
. $CONFIG/.zshalias


# Adjusts starting folder for terminal
cd ~/Desktop/


# Startup info
startup_printout


# Prompt
prompt_pwd () {
  local p=${${PWD:/~/\~}/#~\//\~/}
  psvar[1]="${(@j[/]M)${(@s[/]M)p##*/}##(.|)?}$p:t"
}

precmd_functions+=( prompt_pwd )
PS1='%F{cyan}%1v%f $ '


# Configures ZSH syntax highlighting
syntax_highlight_config


# Initializes ZSH autocompletions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


# Enables ZSH anonymous commands with spaces
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
