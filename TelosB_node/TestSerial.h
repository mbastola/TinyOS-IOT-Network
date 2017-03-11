
#ifndef TEST_SERIAL_H
#define TEST_SERIAL_H

enum {
 	AM_BLINKTORADIO = 6,
	TIMER_PERIOD_MILLI = 2000
 };

 typedef nx_struct Mote2Base 
 {
  nx_uint16_t nodeid;
  nx_uint16_t sensor;
  nx_uint16_t rssi;
  }Mote2Base;

 typedef nx_struct radio_count_msg {
   nx_uint16_t counter;
 } radio_count_msg_t;


#endif
