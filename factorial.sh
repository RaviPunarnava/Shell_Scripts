#!/bin/bash
echo "Enter The Number, please keep the number low"
read num
factor=1
while [ $num -ne 0 ]; do
	factor=$(expr $factor \* $num)
	num=$(expr $num - 1)
done
echo $factor