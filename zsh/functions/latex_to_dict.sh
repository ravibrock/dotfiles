function gen {
    detex $1 \
        | tr -s ' ' '\n' \
        | grep -v '[0-9]\|[[:alnum:]][[:upper:]][[:alnum:]]' \
        | grep -i '[aeiouy]' \
        | grep -E '^[[:alnum:]]+(\x27[[:alnum:]]+)*$' \
        | sed 's/[[:punct:]]*$//g' \
        | sed 's/^[[:punct:]]*//g' \
        | awk 'length($0)>3' \
        | sort -fr \
        | uniq -i \
        | sort \
        | awk '{ print $2 " " $1 }' \
        | cut -c 2-
}

if [[ $1 == "gen" ]]; then
    gen $2
elif [[ $1 == "diff" ]]; then
    grep -vxif $3 $2
else
    echo "Usage: $0 <gen|diff> <file1> <file2>"
fi
