if [ -n "${2+1}" ]
then
    file=$2
else
    file="${1%.*}".pdf
fi

magick $1 $file
rm $1
pdf2ps $file
psfile="${file%.*}".ps
ps2pdf $psfile
rm $psfile
