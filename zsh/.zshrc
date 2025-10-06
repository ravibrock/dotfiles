# Adjusts starting folder for terminal
cd ~/Desktop

# Automatically change directories
setopt autocd
setopt autopushd
setopt pushdignoredups

# Startup info
function startup_printout {
    if [ ${TERM_PROGRAM+1} ]; then
        sleep 0.018
        echo
        flashfetch
        echo
    else
        echo Current user: $(whoami)@$(hostname -s) with $(ifconfig en0 | grep ether | awk '{print $2}')
    fi
}
startup_printout

# Hooks
autoload -Uz add-zsh-hook

# Enable comments in interactive shells
setopt interactive_comments

# Prompt
function prompt_pwd {
    cd "$(readlink -f .)" # Capitalize directory names
    local p=${${PWD:/~/\~}/#~\//\~/}
    psvar[1]="${(@j[/]M)${(@s[/]M)p##*/}##(.|)?}$p:t"
}
add-zsh-hook precmd prompt_pwd
PROMPT="%F{cyan}%1v%f ❯ "

# Window title
DISABLE_AUTO_TITLE="True"
function title { echo -en "\e]0; $(print -rD $PWD)\a" }
add-zsh-hook precmd title

# Zsh history settings
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=999999999
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME

# Zsh vi mode settings
bindkey -v
bindkey -M viins ^H backward-char
bindkey -M viins ^J down-line-or-history
bindkey -M viins ^K up-line-or-search
bindkey -M viins ^L forward-char
echo -ne "\e[1 q"
export KEYTIMEOUT=1
zle_highlight=( region:bg=cyan,fg=black )
function zle-line-init { zle -K viins; echo -ne "\e[1 q" }
zle -N zle-line-init

# Defers certain commands
source ~/.zsh/zsh-defer/zsh-defer.plugin.zsh
function deferred_commands {
    # Completions setup
    zstyle ":completion:*" matcher-list "m:{[:lower:]}={[:upper:]}"
    autoload -Uz compinit
    compinit -u

    # Clean history automatically
    function command-not-found {
        (( ? == 127 )) &&
        sed -i '' '$d' ~/.zsh_history
    }
    add-zsh-hook precmd command-not-found

    # Enables/disables virtual environments and sources env files
    function activator {
        while true; do
            if [[ -e venv/bin/activate ]]; then
                if [[ $CURRENT_VENV != $PWD ]]; then
                    if [[ -v VIRTUAL_ENV ]] deactivate
                    source venv/bin/activate
                    export CURRENT_VENV=$PWD
                fi
                break
            elif [[ $PWD == /Users/* ]]; then
                cd ..
            else
                if [[ -v VIRTUAL_ENV ]] deactivate
                unset CURRENT_VENV
                break
            fi
        done
        cd $1
    }
    function activate_venv {
        add-zsh-hook -d chpwd activate_venv
        activator $PWD
        add-zsh-hook chpwd activate_venv
    }
    add-zsh-hook chpwd activate_venv && cd .

    # Set aliases
    source $DOTFILES/zsh/.zshalias

    # Load functions
    for file in $DOTFILES/zsh/functions/*; do
        autoload -Uz $file
        alias -g $( basename $file .zsh )=$( basename $file )
    done

    # Plugins
    source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

    # Plugin config
    zstyle ':completion:*:git-checkout:*' sort false
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion:*' menu no
    zstyle ':fzf-tab:*' switch-group '<' '>'
    fast-theme $DOTFILES/zsh/.zcolors.ini

    # Vi mode final config
    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] || [[ $1 = "block" ]]; then
            echo -ne "\e[2 q"
        elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = "" ]] || [[ $1 = "beam" ]]; then
            echo -ne "\e[1 q"
        fi
    }
    zle -N zle-keymap-select

    # Zoxide setup
    eval "$(zoxide init zsh)"
}
zsh-defer deferred_commands
export GPG_TTY=$(tty)
