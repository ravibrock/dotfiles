# Window title
DISABLE_AUTO_TITLE="True"
precmd () { echo -en "\e]0; $(print -rD $PWD)\a" }

# Adjusts starting folder for terminal
cd ~/Desktop

# Startup info
startup_printout () {
    if [ ${TERM_PROGRAM+1} ]; then
        echo
        flashfetch --multithreading true
        echo
    else
        echo Current user: $(whoami)@$(hostname -s) with $(ifconfig en0 | grep ether | awk '{print $2}')
    fi
}
startup_printout

# Prompt
prompt_pwd () {
  local p=${${PWD:/~/\~}/#~\//\~/}
  psvar[1]="${(@j[/]M)${(@s[/]M)p##*/}##(.|)?}$p:t"
}
precmd_functions+=( prompt_pwd )
PS1='%F{cyan}%1v%f ❯ '

# Zsh history settings
HISTSIZE=500
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

# Zsh vi mode settings
bindkey -v
echo -ne "\e[1 q"
export KEYTIMEOUT=1
zle_highlight=( region:bg=cyan,fg=black )
zle-line-init () { zle -K viins; echo -ne "\e[1 q" }
zle -N zle-line-init

# Automatically change directories
setopt autocd
setopt autopushd
setopt pushdignoredups

# Defers certain commands
source ~/.zsh/zsh-defer/zsh-defer.plugin.zsh
deferred_commands () {
    # Autosuggestions
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

    # Load compinit
    autoload -Uz compinit
    compinit -u

    # More Zsh config
    source $CONFIG/.zshalias
    source $CONFIG/.zfunc

    # Syntax highlighting
    source $CONFIG/functions/syntax_highlight_config.zsh

    # Vi mode final config
    zle-keymap-select () {
    if [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 = 'block' ]]; then
            echo -ne '\e[2 q'
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
                    echo -ne '\e[1 q'
    fi
}
zle -N zle-keymap-select
}
zsh-defer deferred_commands
