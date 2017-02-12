#!/bin/bash
# http://magic3.blog.51cto.com/1146917/1428197
# 9*9.sh

for (( i=1;i<=9;i++ ))
do
    for (( j=1;j<=i;j++  ))
    do
       let "tmp=i*j"
       echo  -n "$i*$j=$tmp "
    done
    echo ""
done
