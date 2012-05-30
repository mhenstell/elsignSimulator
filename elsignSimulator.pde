import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;
import processing.opengl.*;
import javax.media.opengl.GL;

PeasyCam pCamera;



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

}

void draw() {
  background(0);
  lights();
  noStroke();
 

  
}


