for q in $(ls *.sql); do
	/opt/virtuoso-7.1.0/bin/isql-vt 1111 dba b4LyNAYmIfflH84JS1P5 < $q  | grep msec >>  results/$q.txt
done
