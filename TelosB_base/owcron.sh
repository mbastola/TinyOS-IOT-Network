#! /bin/bash

proj_dir="/home/pi/Final_project_base/BaseStation"
fileUpdate="${proj_dir}/lastupdated"
export MOTECOM=serial@/dev/ttyUSB0:telosb
source /home/pi/tinyos-main/tinyos.env
while (sleep 1)  
do
    if [ -e "$fileUpdate" ];then 
	echo "file created"
	java net.tinyos.tools.Send 00 00 02 00 00 02 33 06 ff ff 02 02
	rm $fileUpdate
	wait $!
    else
	echo "....."
    fi
done