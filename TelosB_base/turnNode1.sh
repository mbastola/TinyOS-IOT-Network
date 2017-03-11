#! /bin/bash

proj_dir="/home/pi/Final_project_base/BaseStation"
date_today="$(date +%m-%d-%y)"
lightFile="light_${date_today}.txt"
tempFile="temp_${date_today}.txt"
humidityFile="humidity_${date_today}.txt"
export MOTECOM=serial@/dev/ttyUSB0:telosb
java net.tinyos.tools.Send 00 00 01 00 00 02 33 06 ff ff 01 01