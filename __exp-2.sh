#!/bin/bash

echo "" > /var/log/syslog 
sync

name=$1
weights=$2
schedtype=$3
suffix=$4

outfile=$name-$suffix

echo "$name: $weights"
echo "$weights" >> $outfile.results
echo "------------" >> $outfile.results

sudo exp_nr=2 weights="$weights" $schedtype LD_LIBRARY_PATH=/usr/local/lib \
     ./bin/parsecmgmt -c gcc-hooks -a run -p $name -n 4 -i native \
     | grep "energy" >> $outfile.results

cat /var/log/syslog | grep Heartbeat > $outfile.log
# Isolate lines containing useful information.
grep -E '(Migrating|Targets|share)' $outfile.log > $outfile.tmp

# Copy [test].tmp into [test].results, pruning useless information.
while read in
do
	res=${in##*Heartbeat: }

	# If this line contains CPU share information, it'll contain
	# a big ugly fraction like "xxxxxxxxx/yyyyyyyyy". So let's
	# do some extra formatting by piping that into `bc` and
	# appending it to the end.
	is_share=$(echo $res | grep share)
	if [ -n "$is_share" ]
	then
		share_frac=${res##*share: } # x/y
		share=$(echo "scale=3; $share_frac" | bc)
		res="$res ($share)"
	fi

	echo $res >> $outfile.results
done < $outfile.tmp

echo "" >> $outfile.results

rm $outfile.tmp
