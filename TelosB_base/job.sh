#! /bin/bash

proj_dir="/home/pi/Final_project_base/BaseStation"
data_dir="${proj_dir}/datasets"
date_today="$(date +%m-%d-%y)"
lightFile="light_${date_today}.tsv"
tempFile="temp_${date_today}.tsv"
humidityFile="humidity_${date_today}.tsv"
export MOTECOM=serial@/dev/ttyUSB0:telosb
while true; do
    while read line
    do
	data_pre="$(echo $line | cut -f13 -d' ')"
	data_post="$(echo $line | cut -f14 -d' ')"
	if [ $data_pre != "" ];then
	    time_received=$(date +%H:%M)
	    data0=${data_post:1:1}
	    data1=${data_post:0:1}
	    data2=${data_pre:1:1}
	    data3=${data_pre:0:1}
	    data_str="${data_pre}${data_post}"
	    data=$((16#${data_str}))
	    sensor_str="$(echo $line | cut -f12 -d' ')"
	    sensor=${sensor_str:1:1}
	    nodeid="$(echo $line | cut -f10 -d' ')"
	    if [ "$data" -gt "20000" ];then ##overflow
		data=$(($data-65536)) #largest 16bit number
	    fi
	    if [ $sensor == "0" ];then
#		echo "${nodeid} Light: ${data}"
		echo -e "${time_received}\t${data}" >> "${data_dir}/${nodeid}_${lightFile}"
	    elif [ $sensor == "1" ];then
#		echo "${nodeid} Temperature: ${data}"
		echo -e "${time_received}\t${data}" >> "${data_dir}/${nodeid}_${tempFile}"
	    else
#		echo "${nodeid} Humidity: ${data}"
		echo -e "${time_received}\t${data}" >> "${data_dir}/${nodeid}_${humidityFile}"
	    fi
	fi
	done< <(java net.tinyos.tools.Listen)
done
