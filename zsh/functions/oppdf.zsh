file="${1%.*}.ps"
pdf2ps $1 $file
ps2pdf $file $1
rm $file
