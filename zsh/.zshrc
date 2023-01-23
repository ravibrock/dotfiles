# Fig pre block - keep at top of file
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"


# Conda initialization
__conda_setup="$(~'/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f '~/opt/anaconda3/etc/profile.d/conda.sh' ]; then
        . '~/opt/anaconda3/etc/profile.d/conda.sh'
    else
        export PATH='~/opt/anaconda3/bin:$PATH'
    fi
fi
unset __conda_setup


# Configures pnpm
export PNPM_HOME='~/Library/pnpm'
export PATH="$PNPM_HOME:$PATH"


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
