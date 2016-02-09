#!/bin/bash
FILES=/home/minna/kansaTaisteliLehdet/*.pdf
for f in $FILES
do
  fNameFirst=${f##*/}
  fName=${fNameFirst%.*}
  ocr=fName
  echo "Processing $fName file..."
  DIR="DIR_$fName"
  mkdir $DIR
  cp $f $DIR/
  cd $DIR
  gs -dNOPAUSE -sDEVICE=jpeg -dFirstPage=1 -sOutputFile=output%d.jpg -dJPEGQ=100 -r500 -q $fNameFirst -c quit
  #tesseract output%d.jpg $ocr%d.txt -l fin 
  for i in $(ls -v *.jpg) ; do echo "$i $i.txt" ; tesseract $i $i.txt -l fin; done
  #cat $f
  cd ..
done
