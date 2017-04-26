#!/bin/bash
FAIL=0
q=$1
i=$2


/opt/virtuoso-7.1.0/bin/isql-vt 1111 dba b4LyNAYmIfflH84JS1P5 < lubm-load.sql
echo "Realizando test: query $q con $i iteraciones"
for i in {1..$2}; do
	/opt/virtuoso-7.1.0/bin/isql-vt 1111 dba b4LyNAYmIfflH84JS1P5 < $q  | grep msec >>  results/p/$q-$i.txt &
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