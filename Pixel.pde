class Pixel
{
  float x;
  float y;
  float z;
  float w;
  float h;
  int sides;
  color c;
  
  float DEFAULT_WIDTH = 3;
  float DEFAULT_HEIGHT = 10;
  int DEFAULT_SIDES = 20;
  
  public Pixel(float x_, float y_, float z_, float w_, float h_, int sides_) {
    x = x_;
    y = y_;
    z = z_;
    w = w_;
    h = h_;
    sides = sides_;
  }
  
  public Pixel(int x_, int y_) {
    x = int(x_);
    y = int(y_);
    w = DEFAULT_WIDTH;
    h = DEFAULT_HEIGHT;
    sides = DEFAULT_SIDES;
    c = color(255, 255, 255);
  }
  
  public Pixel(int x_, int y_, float h_) {
    x = int(x_);
    y = int(y_);
    w = DEFAULT_WIDTH;
    h = h_;
    sides = DEFAULT_SIDES;
    c = color(255, 255, 255);
  }
  
  void draw() {
    fill(c);
    
    pushMatrix();
      translate(x * 10, 0, y * 10);
      cylinder(w, h, sides);
    popMatrix();
 
  }
  
  void update(color c_) {
     c = c_;
     
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
