#!/bin/bash
community=$1
host=$2
version="1"


date=$(date +%s)
list=$(snmpwalk -v $version $host -c $community SYNOLOGY-RAID-MIB::raidStatus)
echo "["
count=0

while read -r line; do
	if (($count != 0)); then
	   echo -n ","
	fi 

	index=$(echo $line | awk -F= '{print $1}' | awk -F. '{print $2}')
	index=$(echo $index | xargs) 
	value=$(echo $line | awk -F= '{print $2}' | awk -F: '{print $2}')
	value=$(echo $value | xargs) 
	echo "{\
	    \"endpoint\"   : \"synology-$host\",\
	    \"tags\"       : \"raid=$index\",\
	    \"timestamp\"  : $date,\
	    \"metric\"     : \"synology.raidStatus\",\
	    \"value\"      : $value,\
	    \"counterType\": \"GAUGE\",\
	    \"step\"       : 60}"
	count=$((count+1))
done <<< "$list"

echo "]"
