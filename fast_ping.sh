#!/bin/bash
# fast_ping.sh
# 根据网络配置对网络地址192.168.0进行修改
for ip in 192.168.0.{1..255};
do
  (
    ping $ip -c2 &> /dev/null;
    
    if [ $? -eq 0 ];
    then
      echo $ip is alive
    fi
  )&
done
wait


# 将循环体放入()&，()中的命令作为子shell来运行，而&会将其置入后台；wait放在脚本最后，它会一直等到所有的子脚本进程全部结束

# fping
# -a :指定打印出所有活动主机的IP地址
# -u :指定打印出所有无法到达的主机
# -g :指定从“IP地址/子网掩码”记法或者“IP地址范围”记法中生成一组IP地址

fping -a 192.168.0.0/24 -g

fping -a 192.168.0.1 192.168.0.255 -g

fping -a 192.168.0.1 192.168.0.2 192.168.0.5

fping -a < ip.list
