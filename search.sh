#!/bin/bash
DIR=/tmp
echo -n "[+] Running Wget in $1"
wget -U " Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko" -q $1 -O $DIR/$1.html 
echo " ->>> DONE"
echo "[+] Starting routine to find hosts from domain"
for i in $(egrep -i '<a href="\w+:..\w+.\w+.\w+' $DIR/$1.html  -o | cut -d '/' -f 3 | sort  | uniq | grep $1);do
#	host -4 $i
	echo "$i : " $(dig $i +short)
done
echo "[+] DONE"
echo "[+] Cleaning"
rm $DIR/$1.html
