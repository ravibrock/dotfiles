# Window title
DISABLE_AUTO_TITLE="true"
precmd () { echo -en "\e]0;$(dirs)\a" }

# Adjusts starting folder for terminal
cd ~/Desktop

# Startup info
startup_printout () {
    if [ ${IS_PYCHARM+1} ]
        then
            echo Current user: $(whoami)@$(hostname -s) with $(spoofed_mac_address)
        else
            echo
            fastfetch \
                --multithreading true \
                --structure Title:Separator:OS:Host:CPU:GPU:Bios:WM:WMTheme:Shell:Processes:Terminal:TerminalFont:Packages:Uptime:Date:Time
            echo
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

# Sets up Zsh vim mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_VI_HIGHLIGHT_FOREGROUND=black
ZVM_VI_HIGHLIGHT_BACKGROUND=cyan

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

# Defers certain commands
source ~/.zsh/zsh-defer/zsh-defer.plugin.zsh
deferred_commands () {
    source $CONFIG/.zshalias
    source $CONFIG/.zfunc
    source $CONFIG/functions/syntax_highlight_config.zsh
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    zmodload zsh/zprof
    zload () { for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit | grep "real"; done; }
}
zsh-defer deferred_commands
