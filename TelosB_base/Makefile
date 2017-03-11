COMPONENT=BaseStationC

INCLUDES= -I..               \
          -I../InterceptBase

CFLAGS += $(INCLUDES)

ifneq ($(filter iris,$(MAKECMDGOALS)),) 
	CFLAGS += -DRF230_RSSI_ENERGY
endif

BUILD_EXTRA_DEPS += RssiDemo.class
CLEAN_EXTRA = *.class

RssiDemo.class: $(wildcard *.java) RssiDemoMsg.java
	javac -target 1.4 -source 1.4 *.java

RssiDemoMsg.class: RssiDemoMsg.java
	javac RssiDemoMsg.java

RssiDemoMsg.java:
	mig java -target=null -java-classname=RssiDemoMsg ../RssiDemoMessages.h RssiDemoMsg -o $@


include $(MAKERULES)
