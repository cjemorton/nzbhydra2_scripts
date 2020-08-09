#!/usr/bin/env sh

nodes=$(cbsd jwhereis nzbhydra2 |xargs)

for x in $nodes; do

r_jid=$(cbsd rexe node=$x cbsd jstatus nzbhydra2)
j_stat=$(cbsd rexe node=$x cbsd jls | grep nzbhydra2 | grep $x | xargs | tr ' ' '\n' | tail -n2 |xargs)

if [ $r_jid -eq '0' ]; then
		# Return when jail is not on.
		echo "Node: $x, Status: $j_stat"

		# If node has jail status as off, start the jail.
		if [ "$(echo "$j_stat" | xargs | cut -c1-3)" == "Off" ]; then
		# Start the Jail.
		cbsd rexe node=$x cbsd jstart nzbhydra2
		fi
	else
		# Return when jail is on.
		echo "Node: $x, Status: $j_stat"
	fi
done
