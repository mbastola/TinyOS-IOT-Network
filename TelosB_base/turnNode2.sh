#! /bin/bash

proj_dir="/home/pi/Final_project_base/BaseStation"
date_today="$(date +%m-%d-%y)"
dummy="${proj_dir}/out"
lightFile="light_${date_today}.txt"
tempFile="temp_${date_today}.txt"
humidityFile="humidity_${date_today}.txt"
source /home/pi/tinyos-main/tinyos.env
echo "${date_today}" > $dummy
export MOTECOM=serial@/dev/ttyUSB0:telosb
echo $MOTECOM >> $dummy
java net.tinyos.tools.Send 00 00 02 00 00 02 33 06 ff ff 02 02 >> $dummy
