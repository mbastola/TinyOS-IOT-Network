#TinyOS IOT Network

Simple 2-way communicaiton between central Raspberry pi utilizing TelosB motes as base station and sensor nodes installed in Apartment living room space. The Pi communicates to the base mote using USB seial comm protocol. The motes interact with the base sensor utilizing TinyOS comm protocols. All communications from server to nodes are IEEE 802.15.4 Broadcast. 

Web Dashboard displays Light, Temperature and Humidity sensor data form each node in realtime. The dashboard controls Light turn on/off command to any node sensor.

For Web Dashboard:

Install Apache: sudo apt install apache2
Install PHP5 : sudo apt get install php5
copy files to a directory website in /var/www/
Give file permissions to www-data as user or group 

For Basestation:

cd directorty TelosB_base
Build using make telosb and install.# telosb
run listen using ./joh.sh
run command from web using ./owcron.sh

For Nodes:

cd directorty TelosB_node
Build using make telosb and install.# telosb

