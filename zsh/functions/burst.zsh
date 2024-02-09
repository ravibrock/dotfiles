function convert {
    if [[ $2 == "" ]] || [[ ! $2 < 0 ]]; then
        echo $2 | xargs
        return
    fi
    PAGES=$(pdftk $1 dump_data | grep "NumberOfPages" | awk '{print $2}')
    echo $(expr $PAGES + $2 + 1)
}

if [ "$1" = "" ]; then
    echo "Usage: <pdf> [start] [end]"
    return
fi

2=$(convert $1 $2)
3=$(convert $1 $3)

HARDPATH=$(readlink -f "$1")
if [ "$3" != "" ]; then
    pdftk $HARDPATH cat "$2"-"$3" output tmp.pdf
elif [ "$2" != "" ]; then
    pdftk $HARDPATH cat "$2"-end output tmp.pdf
else
    cp $HARDPATH tmp.pdf
fi

pdftk tmp.pdf burst
rename -f "s/pg_00/${1%.*}_/" *.pdf
rm -f tmp.pdf doc_data.txt
