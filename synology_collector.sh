#!/bin/bash

# workdir refers to the directory where synology.*.sh scripts reside. 
workdir=.
# community refers to the "community string" in snmpcmd
community="COMMUNITY_STRING"
# targets refers to the "AGENT" array in snmpcmd 
targets=( example1.com example2.com )
# httpprex refers to the open-falcon agent that can receive json.
httpprex=127.0.0.1:1988

for host in "${targets[@]}"
do 
	curl -s -X POST -d "$($workdir/synology-cpuidle.sh $community "${host}" | python -m json.tool)" "$httpprex/v1/push" &
	curl -s -X POST -d "$($workdir/synology-cpusystem.sh $community "${host}" | python -m json.tool)" "$httpprex/v1/push" &
	curl -s -X POST -d "$($workdir/synology-cpuuser.sh $community "${host}" | python -m json.tool)" "$httpprex/v1/push" &
	curl -s -X POST -d "$($workdir/synology-diskstatus.sh $community "${host}" | python -m json.tool)" "$httpprex/v1/push" &
	curl -s -X POST -d "$($workdir/synology-memory.sh $community "${host}" | python -m json.tool)" "$httpprex/v1/push" &

	curl -s -X POST -d "$($workdir/synology-net_in.sh $community "${host}" | python -m json.tool)" "$httpprex/v1/push" &
	curl -s -X POST -d "$($workdir/synology-net_out.sh $community "${host}" | python -m json.tool)" "$httpprex/v1/push" &
	curl -s -X POST -d "$($workdir/synology-raidstatus.sh $community "${host}" | python -m json.tool)" "$httpprex/v1/push" &

    sleep 1
done
