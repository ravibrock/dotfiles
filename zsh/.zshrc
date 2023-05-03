# Window title
DISABLE_AUTO_TITLE="true"
precmd () { echo -en "\e]0;$(dirs)\a" }

# Adjusts starting folder for terminal
cd ~/Desktop

# Startup info
startup_printout () {
    if [ ${TERM_PROGRAM+1} ]; then
        echo
        fastfetch \
            --multithreading true \
            --structure Title:Separator:OS:Host:CPU:GPU:Bios:WM:WMTheme:Shell:Processes:Terminal:TerminalFont:Packages:Uptime:Date:Time
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
SAVEHIST=1000
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

zle-line-init () {
    zle -K viins
    echo -ne "\e[1 q"
}
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
    if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
        compinit -u
    else
        compinit -C
    fi

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

    # Zsh timing
    zmodload zsh/zprof
    zload () { for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit | grep "real"; done; }
}
zsh-defer deferred_commands
