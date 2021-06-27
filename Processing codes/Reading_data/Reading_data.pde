
import processing.serial.*;

Serial myPort1,myPort2;
String x1;

void setup(){
  size(500, 500);
  myPort1 = new Serial(this, "COM5", 9600); // Starts the serial communication
  myPort1.bufferUntil('\n'); // Defines up to which character the data from the serial port will be read. The character '\n' or 'New Line'
  myPort2 = new Serial(this, "COM8", 9600); // Starts the serial communication
  myPort2.bufferUntil('\n'); // Defines up to which character the data from the serial port will be read. The character '\n' or 'New Line'
}

void serialEvent (Serial myPort){ // Checks for available data in the Serial Port
  x1 = myPort.readStringUntil('\n'); //Reads the data sent from the Arduino (the String "LED: OFF/ON) and it puts into the "ledStatus" variable
}

void draw(){
  
  background(0);
  
  if(x1.charAt(0)=='B')
  {
    printArray(x1);  
  }
}
