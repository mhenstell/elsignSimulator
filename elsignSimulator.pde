import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;
import processing.opengl.*;
import javax.media.opengl.GL;
import hypermedia.net.*;
import java.util.concurrent.*;

LinkedBlockingQueue newImageQueue;

PeasyCam pCamera;

Sign sign;

UDP udp;

int SIGN_WIDTH = 50;
int SIGN_HEIGHT = 6;

void setup() {
  size(1024, 850, OPENGL);
  colorMode(RGB,255);
  frameRate(60);

  // Turn on vsync to prevent tearing
  PGraphicsOpenGL pgl = (PGraphicsOpenGL) g; //processing graphics object
  GL gl = pgl.beginGL(); //begin opengl
  gl.setSwapInterval(2); //set vertical sync on
  pgl.endGL(); //end opengl

  //size(1680, 1000, OPENGL);
  pCamera = new PeasyCam(this, 0, 0, 0, 200);
  pCamera.setMinimumDistance(.2);
  pCamera.setMaximumDistance(150*10);
  pCamera.setSuppressRollRotationMode();
  pCamera.rotateX(.6);

  pCamera.setWheelScale(0.05);
  
  sign = new Sign(SIGN_WIDTH, SIGN_HEIGHT);
  
  udp = new UDP(this, 58082);
  udp.listen(true);
  
  newImageQueue = new LinkedBlockingQueue();

}

int convertByte(byte b) {
  return (b<0) ? 256+b : b;
}

void receive(byte[] data, String ip, int port) {  

  if (data[0] != 1) {
    println("Packet header mismatch. Expected 1, got " + data[0]);
    return;
  }

  if (data.length != (SIGN_WIDTH * SIGN_HEIGHT) * 3 + 1) {
    println("Packet size mismatch. Expected many, got " + data.length);
    return;
  }

  if (newImageQueue.size() > 0) {
    println("Buffer full, dropping frame!");
    return;
  }

  color[] newImage = new color[SIGN_WIDTH * SIGN_HEIGHT];
  
  for (int i=0; i< SIGN_WIDTH * SIGN_HEIGHT; i++) {
    newImage[i] = color(convertByte(data[i*3 + 1]), 
    convertByte(data[i*3 + 2]), 
    convertByte(data[i*3 + 3]));
  }

  try { 
    newImageQueue.put(newImage);
  } 
  catch( InterruptedException e ) {
    println("Interrupted Exception caught");
  }
}

void draw() {
  background(0);
  lights();
  noStroke();
  
  if (newImageQueue.size() > 0) {
    color[] newImage = (color[]) newImageQueue.poll();

    sign.update(newImage);
  }
 
  sign.draw();
  
}


