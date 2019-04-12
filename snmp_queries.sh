#!/bin/bash

community="COMMUNITY_STRING"
host="example1.com"
version="2c"
snmpbulkwalk="snmpbulkwalk"
snmpdf="snmpdf"
snmpnetstat="snmpnetstat"
snmptable="snmptable"

# 群辉空闲内存
echo "show physical memory"
snmpbulkwalk -v $version -c $community $host .1.3.6.1.4.1.2021.4.6.0

# CPU空闲百分比
echo "show idle CPU"
snmpbulkwalk -v $version -c $community $host .1.3.6.1.4.1.2021.11.11.0

# CPU用户占用百分比
echo "show CpuUser"
snmpbulkwalk -v $version -c $community $host .1.3.6.1.4.1.2021.11.9.0

# CPU系统占用百分比
echo "show ssCpuSystem"
snmpbulkwalk -v $version -c $community $host .1.3.6.1.4.1.2021.11.10.0

#网卡名称  The textual name of the interface
echo "show net.name"
snmpbulkwalk -v $version -c $community $host .1.3.6.1.2.1.31.1.1.1.1

# 网卡出站方向流量
echo "show net.out"
snmpbulkwalk -v $version -c $community $host .1.3.6.1.2.1.31.1.1.1.10

# 网卡进站方向流量
echo "show net.in"
snmpbulkwalk -v $version -c $community $host .1.3.6.1.2.1.31.1.1.1.6

#硬盘状态
echo "show diskStatus"
snmpwalk -v 1 $host -c $community SYNOLOGY-DISK-MIB::diskStatus

#RAID状态
echo "show raidStatus"
snmpwalk -v $version $host -c $community SYNOLOGY-RAID-MIB::raidStatus

