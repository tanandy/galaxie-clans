#!/usr/bin/env bash

#
# Shows DNS query statistics as gathered by tinystats by Luca Morettoni.
#
# Parameters:
#
# 	config   (required)
# 	autoconf (optional - used by munin-config)
#
#%# family=auto
#%# capabilities=autoconf


if [ "$1" = "autoconf" ]; then
	if [ -f "/var/service/tinydns/log/main/tinystats.out" ]; then
		echo yes;
	else
		echo no;
	fi
	exit 0;
fi

if [ "$1" = "config" ]; then

        cat - <<EOF
graph_title tinydns query errors
graph_args --base 1000 -l 0
graph_vlabel queries/sec
graph_category network
graph_info This graph shows the number of queries that tinydns processed.
graph_total Total
other.label Other RR
other.info The number of other RR queries.
other.type DERIVE
other.min 0
other.draw AREA
notauth.label Not authotitative
notauth.info The number of not authotitative queries.
notauth.type DERIVE
notauth.min 0
notauth.draw STACK
notimpl.label Not implemented
notimpl.info The number of not implemented queries.
notimpl.type DERIVE
notimpl.min 0
notimpl.draw STACK
badclass.label Bad class type
badclass.info The number of bad class type queries.
badclass.type DERIVE
badclass.min 0
badclass.draw STACK
noquery.label Empty query
noquery.info The number of empty queries.
noquery.type DERIVE
noquery.min 0
noquery.draw STACK
EOF
	exit 0
fi

cat /var/service/tinydns/log/main/tinystats.out | head -n 1 | awk -F: '{ printf "other.value %d\nnotauth.value %d\nnotimpl.value %d\nbadclass.value %d\nnoquery.value %d\n", $16, $17, $18, $19, $20 }'
