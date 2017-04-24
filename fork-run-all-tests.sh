#!/bin/bash

FAIL=0

for q in $(ls *.sql); do
	/opt/virtuoso-7.1.0/bin/isql-vt 1111 dba b4LyNAYmIfflH84JS1P5 < $q  | grep msec >>  results/p/$q.txt &
done

for job in `jobs -p`
do
echo $job
    wait $job || let "FAIL+=1"
done

echo $FAIL

if [ "$FAIL" == "0" ];
then
echo "YAY!"
else
echo "FAIL! ($FAIL)"
fi
#clean
/etc/init.d/virtuoso restart