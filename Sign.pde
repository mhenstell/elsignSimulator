class Sign
{
 
 ArrayList<Pixel> pixels;
 
 int w;
 int h;
 
 Sign(int w_, int h_) {
   w = w_;
   h = h_; 
   setup();
 }
 
 void setup() {
   
   pixels = new ArrayList<Pixel>();
   
   for (int y = 0; y < h; y++) {
     for (int x = 0; x < w; x++) {
       
        float cylheight = 20 - (sin((TWO_PI / w) * x)) * 10;
        
        pixels.add(new Pixel(x, y, cylheight));
     } 
   }
 }
 
 void draw() {
   
   for (int y = 0; y < h; y++) {
     for (int x = 0; x < w; x++) {
      
       pixels.get((y * w) + x).draw();
     } 
   }

 }
 
 void update(int x, int y, color c) {
   pixels.get((y * w) + x).update(c); 
 }
 
 void update(color[] imageData) {

    for (int i = 0; i < pixels.size(); i++) {
      pixels.get(i).update(imageData[i]);
    }
  }
}
