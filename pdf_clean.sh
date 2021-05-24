argv1 = ""
file_name = "my_pdf.pdf"

cp argv1 file_name

convert -quality 100 -density 600 "$file_name" "$file_name_%d.jpeg"

# moving the JPEGs to another place
#

mogrify -contrast -contrast -contrast -contrast -contrast -contrast -contrast -contrast -- *.jpeg
# cut top border
mogrify -crop 100x100%+100+650% -- *.jpeg
mogrify -format pdf -- *.jpeg
convert `ls -1v` "$file_name.pdf"
ocrmypdf -l spa --output-type pdf "$file_name" "ocr_$file_name"
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.6 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile="opti_$file_name" "ocr_$file_name"

# PDF to CSV method here
#

# csv cleaning
cat "opti_$file_name.csv" | sed 's/"//g;s/,,/,/g;s/VARON\s/VARON,/g;s/MUJER\s/MUJER,/g' > "$file_name.csv"