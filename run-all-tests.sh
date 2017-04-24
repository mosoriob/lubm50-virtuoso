/opt/virtuoso-7.1.0/bin/isql-vt 1111 dba b4LyNAYmIfflH84JS1P5 < lumb-load.sql
for q in $(ls q*.sql); do
	/opt/virtuoso-7.1.0/bin/isql-vt 1111 dba b4LyNAYmIfflH84JS1P5 < $q  | grep msec >>  results/s/$q.txt
done
#clean
/etc/init.d/virtuoso restart