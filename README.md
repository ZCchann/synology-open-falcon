根据项目：https://github.com/humorless/esxicollector 修改过来

使用方法：
1、安装SNMP
yum -y install net-snmp net-snmp-utils
2、下载群晖的MIB档案 存放至/usr/share/snmp/mibs
3、设置SNMP的环境 以存放至/opt/举例
mkdir /opt/open-falcon-synology/
echo "mibs +ALL" > ~/opt/open-falcon-synology/snmp.conf

4、在synology_collector.sh填入合适的参数

5、设置cronjobs
* * * * * synology_collector.sh

当前监控字段
synology.cpu.idle
synology.cpu.system
synology.cpu.user
synology.diskstatus
synology.memfree.kliobytes
synology.net.in.octets
synology.net.out.octets
synology.raidStatus


raidStatus 监控数据解读
返回值为 1 = raid正常运行
返回值为 11 = raid发生故障 已经降级
返回值为 12 = raid已经崩溃

diskstatus 监控数据解读
返回值为 1 = 硬盘正常
返回值为 2 = 硬盘有系统分区 但是没有数据
返回值为 3 = 硬盘在系统分区中没有系统
返回值为 4 = 硬盘在系统分区中没有系统
返回值为 5 = 硬盘已损坏
