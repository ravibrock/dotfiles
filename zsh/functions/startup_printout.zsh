last_user () { last -2 | sed -n 2p | awk '{print "Last login:", $3, $4, $5, $6, "by", $1, "on", $2}' }
current_user () { echo Current user: $(whoami)@$(hostname -s) with $(spoofed_mac_address)\n }
neofetch_custom () { print ""; neofetch --color_blocks off; print "" }

if [ ${IS_PYCHARM+1} ]
    then
    current_user
    else
    neofetch_custom
fi
