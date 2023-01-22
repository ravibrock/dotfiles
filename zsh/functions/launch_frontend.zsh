cd ~/Archive/Business/.Frontends/$1
if [ $1 = 'uniswap' ] || [ $1 = 'Uniswap' ]
then
cd build/
else
cd dist/
fi
serve
