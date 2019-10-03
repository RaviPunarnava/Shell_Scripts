#!/bin/bash
echo .Enter The Number upto which you want to Print Table: .
read n
num=1
while [ $num -ne 10 ]; do
	i=$(expr $num + 1)
	tables=$(expr $num \* $n)
	echo $tables
done