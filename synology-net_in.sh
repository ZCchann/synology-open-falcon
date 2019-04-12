#!/bin/bash
community=$1
host=$2
version="2c"


date=$(date +%s)
count=0
list=$(snmpbulkwalk -v $version -c $community $host .1.3.6.1.2.1.31.1.1.1.1)
listOctet=$(snmpbulkwalk -v $version -c $community $host .1.3.6.1.2.1.31.1.1.1.10)



echo "["
while read -r line; do
	if (($count != 0)); then
		echo -n ","
	fi

        num=$((count+1))
	inner=$(echo "$listOctet" | sed "${num}q;d")
	index=$(echo $line | awk -F= '{print $2}' | awk -F: '{print $2}')
	index=$(echo $index | xargs) 
	value=$(echo $inner | awk -F= '{print $2}' | awk -F: '{print $2}' )
	value=$(echo $value | xargs) 
	echo "{\
	    \"endpoint\"   : \"synology-$host\",\
	    \"tags\"       : \"iface=$index\",\
	    \"timestamp\"  : $date,\
	    \"metric\"     : \"synology.net.in.octets\",\
	    \"value\"      : $value,\
	    \"counterType\": \"COUNTER\",\
	    \"step\"       : 60}"
        count=$((count+1))
done <<< "$list"

echo "]"
