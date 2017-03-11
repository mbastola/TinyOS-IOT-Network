#! /bin/bash

proj_dir="/home/pi/Final_project_base/BaseStation"
data_dir="${proj_dir}/datasets"
date_today="$(date +%m-%d-%y)"
lightFile="light_${date_today}.txt"
tempFile="temp_${date_today}.txt"
humidityFile="humidity_${date_today}.txt"
rsync -avz -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress "${data_dir}/" "piconnect@ec2-52-24-193-191.us-west-2.compute.amazonaws.com:/home/piconnect/datasets/"