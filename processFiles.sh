#!/bin/bash
FILES=/home/minna/kansaTaisteliLehdet/*.pdf
for f in $FILES
do
  #get filenames
  fNameFirst=${f##*/}
  fName=${fNameFirst%.*}
  ocr=fName

  echo "Processing $fName file..."

  #access file directory (assuming that input is in a folder with a corresponding name)
  DIR="DIR_$fName"
  mkdir $DIR
  cp $f $DIR/
  cd $DIR

  #convert pdf to an images (one page, one image)
  gs -dNOPAUSE -sDEVICE=jpeg -dFirstPage=1 -sOutputFile=output%d.jpg -dJPEGQ=100 -r500 -q $fNameFirst -c quit

  #execute tesseract
  for i in $(ls -v *.jpg) ; do echo "$i $i.txt" ; tesseract $i $i.txt -l fin; done
  cd ..
done
