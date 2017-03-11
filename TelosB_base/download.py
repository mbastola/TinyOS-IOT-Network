#!/usr/bin/python

import os
import subprocess

javaserialpath='/home/manil/Desktop/pos/BaseStation' #path to TestSerial.java file
#export MOTECOM=serial@/dev/ttyUSB0:telosb
try:#call on the TestSerial file
	os.chdir(javaserialpath)
	os.system('export MOTECOM=serial@/dev/ttyUSB0:telosb')
		
	print "Calling TestSerial file"
	os.system('java RssiDemo')
	print "TestSerial called successfully"
			
except:
	print 'Call to TestSerial.java failed'
	
	
