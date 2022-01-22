scriptPath='/home/servercheck'
cd $scriptPath
totalmem=`free -m | awk '/^Mem:/ {print $2}'`
freemem=`free -m |  awk '/^-\/+/ {print $4}'`
freememper=`echo "($freemem)*100" | bc`
freememper=`echo "$freememper/$totalmem" | bc`
usedmemper=`echo "100 - $freememper" | bc`
tcpcount=$(netstat -n -t | grep ESTABLISHED | wc -l)
du=$(df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '/^\/dev/ {print $5}')
disk=$(echo $du | tr "%" " ")
cpu=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}')
cpus=`echo "($cpu/1)" | bc`
msg="Production- CPU usage and health check report at $(date) : CPU usage=$cpu%,  Ram usage = $usedmemper%,tcp conn = $tcpcount,disk usage = $du "
echo $msg
echo $cpus
if [ $usedmemper -ge 50 ] || [ $tcpcount -ge 100 ] || [ $disk -ge 70 ] || [ $cpus -ge 70 ] 
then
    	echo $msg > /home/servercheck/healthchkImAlt.txt
