if [ $1 = 'enable' ]
then
    sudo pmset -a destroyfvkeyonstandby 1 hibernatemode 25 standbydelaylow 0 standbydelayhigh 0
fi
if [ $1 = 'disable' ]
then
    sudo pmset -a destroyfvkeyonstandby 0 hibernatemode 3 standbydelaylow 10800 standbydelayhigh 86400
fi
