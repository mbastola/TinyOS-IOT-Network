/*
Modified to do the final project
It collects light sensor data 									
 */

#include "Timer.h"
#include "TestSerial.h"

module TestSerialC {
  uses {
 	interface Boot;
 	interface Leds;
	interface Timer<TMilli> as MilliTimer;
	
	interface SplitControl as Control;
	interface AMSend;
	interface Packet;

 	interface Read<uint16_t> as Photo;
	interface Read<uint16_t> as TempSensor;
	interface Read<uint16_t> as HumiditySensor;
  }
}
implementation {

  message_t pkt;
  u_int16_t ConvertedTemp;
  bool locked = FALSE;
  Mote2Base* msgToSend;	
  
  event void Boot.booted() {
    call Control.start();
  }
  
  event void MilliTimer.fired() {
	call Photo.read();
   
  }
event void Photo.readDone(error_t err, uint16_t value)
	{

    if (!locked) {
		Mote2BaseTmp* btrpkt = (Mote2Base*)(call Packet.getPayload(&pkt, sizeof (Mote2BaseTmp)));
    		btrpkt->nodeid = TOS_NODE_ID;
    		btrpkt->rssi = value;
		msgToSend->nodeid = TOS_NODE_ID;
    		btrpkt->rssi = value;
     
    		}
	if (call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(Mote2Base)) == SUCCESS) 
    		{locked = TRUE;}      
     call Leds.led2Toggle();
      call TempSensor.read();
	}
	

  event void AMSend.sendDone(message_t* msg, error_t error) {
    if (&pkt == msg) {
      locked = FALSE;
      }
  }
  event void TempSensor.readDone(error_t result, u_int16_t val)
	{
		
		if (result==SUCCESS)
		{  
			ConvertedTemp = (-38.4+(0.0098*val));
			
		 	if (!locked) {
				Mote2Base* btrpkt = (Mote2Base*)(call Packet.getPayload(&pkt, sizeof (Mote2Base)));
    				btrpkt->nodeid = TOS_NODE_ID;
    				btrpkt->rssi = ConvertedTemp;     
    					}
			if (call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(Mote2Base)) == SUCCESS) 
    				{locked = TRUE;}  
			
		}
	call HumiditySensor.read();
	}
  event void HumiditySensor.readDone(error_t result, u_int16_t val)
	{
		
		if (result==SUCCESS)
		{
			ConvertedTemp= -4 + 0.0405*val + (-2.8 * val * val / 1000000);
		 	if (!locked) {
				Mote2Base* btrpkt = (Mote2Base*)(call Packet.getPayload(&pkt, sizeof (Mote2Base)));
    				btrpkt->nodeid = TOS_NODE_ID;
    				btrpkt->rssi = ConvertedTemp;     
    					}
			if (call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(Mote2Base)) == SUCCESS) 
    				{locked = TRUE;}  
			
		}
	call Leds.led1Toggle();		
	}


  event void Control.startDone(error_t err) {
    if (err == SUCCESS) {
      call MilliTimer.startPeriodic(12000);
    }
  }
  event void Control.stopDone(error_t err) {}
}




