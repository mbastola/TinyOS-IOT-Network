/**
 * Java-side application for testing serial port communication.
 * 
 *
 * @author Phil Levis <pal@cs.berkeley.edu>
 * @date August 12 2005
 */

import java.io.IOException;
import java.io.*;
import net.tinyos.message.*;
import net.tinyos.packet.*;
import net.tinyos.util.*;
import java.util.*;
import java.sql.Timestamp;

public class RssiDemo implements MessageListener {
  public int counter = 0;  
  private MoteIF moteIF;

    
  public RssiDemo(MoteIF moteIF) {
    this.moteIF = moteIF;
    this.moteIF.registerListener(new RssiDemoMsg(), this);
 }

    /*
  public void sendPackets() {
    int counter = 0;
    RssiDemoMsg payload = new RssiDemoMsg();
    try {
      while (true) {
	System.out.println("Sending packet " + counter);
	payload.set_rssi(counter);
	moteIF.send(0, payload);
	counter++;
	try {Thread.sleep(1000);}
	catch (InterruptedException exception) {}
      }
    }
    catch (IOException exception) {
      System.err.println("Exception thrown when sending packets. Exiting.");
      System.err.println(exception);
    }
  }*/

  public void messageReceived(int to, Message message) {
counter++;

    RssiDemoMsg msg = (RssiDemoMsg)message;
	if(counter%2!=0){
	System.out.println("Light sensor data is " + msg.get_rssi());    
	writelight(String.valueOf(msg.get_rssi()));
	}
	else{	
	   System.out.println("Temp sensor data is " + msg.get_rssi());
	   writetemp(String.valueOf(msg.get_rssi()));
    }
}
  
  private static void usage() {
    System.err.println("usage: RssiDemo [-comm <source>]");
  }

private void writelight(String temp) {
    String fileName = "light.txt";
if (counter>10){
System.exit(1);
}
else{

        try {
            // Assume default encoding.
            FileWriter fileWriter = new FileWriter(fileName,true);

            // Always wrap FileWriter in BufferedWriter.
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

            // Note that write() does not automatically
            // append a newline character.
		Date date=new Date();
		Timestamp time=new Timestamp(date.getTime());
		bufferedWriter.write(time.toString());
		bufferedWriter.write("\t");
            	bufferedWriter.write(temp);
		bufferedWriter.newLine();
		
            // Always close files.
            bufferedWriter.close();
        }
        catch(IOException ex) {
            System.out.println("Error writing to file '"+ fileName + "'");
            // Or we could just do this:
            // ex.printStackTrace();
        }
  }
}

private void writetemp(String temp) {
    String fileName = "temp.txt";
if (counter>10){
System.exit(1);
}
else{

        try {
            // Assume default encoding.
            FileWriter fileWriter = new FileWriter(fileName,true);

            // Always wrap FileWriter in BufferedWriter.
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

            // Note that write() does not automatically
            // append a newline character.
		Date date=new Date();
		Timestamp time=new Timestamp(date.getTime());
		bufferedWriter.write(time.toString());
		bufferedWriter.write("\t");
            	bufferedWriter.write(temp);
		bufferedWriter.newLine();
            // Always close files.
            	bufferedWriter.close();
        }
        catch(IOException ex) {
            System.out.println("Error writing to file '"+ fileName + "'");
            // Or we could just do this:
            // ex.printStackTrace();
        }
  }
}
  
  
  
  public static void main(String[] args) throws Exception {
    String source = null;
    if (args.length == 2) {
      if (!args[0].equals("-comm")) {
	usage();
	System.exit(1);
      }
      source = args[1];
    }
    else if (args.length != 0) {
      usage();
      System.exit(1);
    }
    
    PhoenixSource phoenix;
    
    if (source == null) {
      phoenix = BuildSource.makePhoenix(PrintStreamMessenger.err);
    }
    else {
      phoenix = BuildSource.makePhoenix(source, PrintStreamMessenger.err);
    }

    MoteIF mif = new MoteIF(phoenix);
    RssiDemo serial = new RssiDemo(mif);
    serial.sendPackets();
  }


}
