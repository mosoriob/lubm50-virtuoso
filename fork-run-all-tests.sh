#!/bin/bash
function esperar {
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
}
FAIL=0
/opt/virtuoso-7.1.0/bin/isql-vt 1111 dba b4LyNAYmIfflH84JS1P5 < lubm-load.sql

for i in {1..3}; do
	/opt/virtuoso-7.1.0/bin/isql-vt 1111 dba b4LyNAYmIfflH84JS1P5 < $q  | grep msec >>  results/p/$q.txt &
done
esperar
for i in {4..6}; do
	/opt/virtuoso-7.1.0/bin/isql-vt 1111 dba b4LyNAYmIfflH84JS1P5 < $q  | grep msec >>  results/p/$q.txt &
done
esperar

#clean
/etc/init.d/virtuoso restart