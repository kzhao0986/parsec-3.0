#!/bin/bash

echo "" > /var/log/syslog 
sync

name=$1
ratio=$2

sudo RATIO=$ratio LD_LIBRARY_PATH=/usr/local/lib ./bin/parsecmgmt \
                  -c gcc-hooks -a run -p $name -n 2 -i native

# Dump log to [test].log
cat /var/log/syslog | grep Heartbeat > $name.log
# Isolate lines containing perf targets and CPU shares
grep -E '(Targets|share)' $name.log > $name.tmp

echo "$ratio to 1" >> $name.results
echo "------------" >> $name.results

# Copy [test].tmp into [test].results, pruning useless information.
while read in
do
	res=${in##*Heartbeat: }
	echo $res >> $name.results
done < $name.tmp

echo "" >> $name.results

rm $name.tmp
