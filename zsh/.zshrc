# Open tmux
if [[ -v TMUX ]]; then
    tmux switch -t 0
else
    tmux
fi

# Adjusts starting folder for terminal
cd ~/Desktop

# Automatically change directories
setopt autocd
setopt autopushd
setopt pushdignoredups

# Startup info
startup_printout () {
    if [ ${TERM_PROGRAM+1} ]; then
        echo
        flashfetch
        echo
    else
        echo Current user: $(whoami)@$(hostname -s) with $(ifconfig en0 | grep ether | awk '{print $2}')
    fi
}
startup_printout

# Enable comments in interactive shells
setopt interactive_comments

# Prompt
prompt_pwd () {
    local p=${${PWD:/~/\~}/#~\//\~/}
    psvar[1]="${(@j[/]M)${(@s[/]M)p##*/}##(.|)?}$p:t"
}
precmd_functions+=( prompt_pwd )
PROMPT="%F{cyan}%1v%f ❯ "

# Window title
DISABLE_AUTO_TITLE="True"
precmd () { echo -en "\e]0; $(print -rD $PWD)\a" }

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
ZVM_NORMAL_MODE_CURSOR="\e[2 q"
ZVM_INSERT_MODE_CURSOR="\e[1 q"
ZVM_VI_HIGHLIGHT_BACKGROUND="cyan"
ZVM_VI_HIGHLIGHT_FOREGROUND="black"
source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh
function zvm_after_init () {
    zvm_bindkey viins "^H" backward-char
    zvm_bindkey viins "^J" down-line-or-history
    zvm_bindkey viins "^K" up-line-or-search
    zvm_bindkey viins "^L" forward-char
}

# Defers certain commands
source ~/.zsh/zsh-defer/zsh-defer.plugin.zsh
deferred_commands () {
    # Autosuggestions
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

    # Clean history automatically
    autoload -Uz add-zsh-hook
    command-not-found () {
        (( ? == 127 )) &&
        sed -in '$d' ~/.zsh_history
    }
    add-zsh-hook precmd command-not-found

    # Enables/disables virtual environments
    function activator () {
        if [[ -e "venv/bin/activate" ]]; then
            if [[ $CURRENT_VENV != $PWD ]]; then
                source venv/bin/activate
                export CURRENT_VENV=$PWD
            fi
            cd $1
        elif [[ $PWD == /Users/* ]]; then
            cd ..
            activator $1
        else
            if [[ -v VIRTUAL_ENV ]] deactivate
            unset CURRENT_VENV
            cd $1
        fi
    }
    function activate_venv () {
        add-zsh-hook -d chpwd activate_venv
        activator $PWD
        add-zsh-hook chpwd activate_venv
    }
    add-zsh-hook chpwd activate_venv && cd .

    # Completions setup
    zstyle ":completion:*" matcher-list "m:{[:lower:]}={[:upper:]}"
    autoload -Uz compinit
    compinit -u

    # Conda init
    __conda_setup="$("$HOME/miniforge3/bin/conda" "shell.zsh" "hook" 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
            . "$HOME/miniforge3/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/miniforge3/bin:$PATH"
        fi
    fi
    unset __conda_setup

    # More Zsh config
    source $CONFIG/.zshalias
    source $CONFIG/.zfunc

    # Syntax highlighting
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source $CONFIG/functions/syntax_highlight_config.zsh
}
zsh-defer deferred_commands
