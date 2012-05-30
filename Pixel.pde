class Pixel
{
  float x;
  float y;
  float z;
  float w;
  float h;
  int sides;
  
  Pixel(float x_, float y_, float z_, float w_, float h_, int sides_) {
    x = x_;
    y = y_;
    z = z_;
    w = w_;
    h = h_;
    sides = sides_;
  }
  
  void draw() {
    
    pushMatrix();
      translate(x, y, z);
      cylinder(w, h, sides);
    popMatrix();
 
  }
  
  /**
  cylinder taken from http://wiki.processing.org/index.php/Cylinder
  @author matt ditton
  */
   
  void cylinder(float w, float h, int sides)
  {
    float angle;
    float[] x = new float[sides+1];
    float[] z = new float[sides+1];
   
    //get the x and z position on a circle for all the sides
    for(int i=0; i < x.length; i++){
      angle = TWO_PI / (sides) * i;
      x[i] = sin(angle) * w;
      z[i] = cos(angle) * w;
    }
   
    //draw the top of the cylinder
    beginShape(TRIANGLE_FAN);
   
    vertex(0,   -h/2,    0);
   
    for(int i=0; i < x.length; i++){
      vertex(x[i], -h/2, z[i]);
    }
   
    endShape();
   
    //draw the center of the cylinder
    beginShape(QUAD_STRIP); 
   
    for(int i=0; i < x.length; i++){
      vertex(x[i], -h/2, z[i]);
      vertex(x[i], h/2, z[i]);
    }
   
    endShape();
   
    //draw the bottom of the cylinder
    beginShape(TRIANGLE_FAN); 
   
    vertex(0,   h/2,    0);
   
    for(int i=0; i < x.length; i++){
      vertex(x[i], h/2, z[i]);
    }
   
    endShape();
  } 
}
