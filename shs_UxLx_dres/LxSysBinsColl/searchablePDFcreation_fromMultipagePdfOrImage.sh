
##-- converting a multipage PDF file which basically consists of scanned images into searchable PDF-file,
##-- http://tfischernet.wordpress.com/

TEMPDIR=$(mktemp -d)
INPUTPDF="$1"
OUTPUTPDF="${INPUTPDF/.pdf/-index.pdf}"

gs -r320 -dBATCH -dNOPAUSE -sOutputFile=${TEMPDIR}/page%05d.tiff -sDEVICE=tiffgray "${INPUTPDF}" || exit 1
for tiff in ${TEMPDIR}/page*.tiff ; do
	hocr=${tiff/.tiff/.hocr}
	pdf=${tiff/.tiff/.pdf}
	cuneiform -f hocr -o ${hocr} ${tiff} && \
		hocr2pdf -i ${tiff} -o ${pdf} <${hocr} || \
		exit 2
done
pdftk ${TEMPDIR}/page*.pdf output "${OUTPUTPDF}"

rm -rf ${TEMPDIR}

