if [ "$1" = "" ]; then
    echo "Usage: <pdf> [start] [end]"
    return
fi

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
