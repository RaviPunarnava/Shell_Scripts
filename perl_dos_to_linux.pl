#this perl script converts windows type of file to Linux type of file
#winfile is the text file in windows type formatting or windows type end of line
# unix file is text file with linux type end of file
perl -p -e 's/\r$//' < winfile.txt > unixfile.txt
