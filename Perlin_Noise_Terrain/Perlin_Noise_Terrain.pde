boolean flag;
int cols, rows;
int w = 1200; 
int h = 1600; 
int scl = 20;

float flying = 0;
float[][] terrain;

void setup() {
 size(600, 600, P3D); 
  flag = false;
  
  rows = h/scl; 
  cols = w/scl;
  terrain = new float[cols][rows];

  
  frameRate(30);
  
}

void draw() {
  flying -= 0.31;
 background(0); 
 if(!flag) {
   flag = true;
 }
 
   float yoff = flying;
  for(int y = 0; y < rows; y++) {
    float xoff = 0;
     for(int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff,yoff), 0, 1, -100,100); ;
      xoff += 0.2;
     }
     yoff += 0.2;
   }
  stroke(255);
  noFill();
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/2);
 for(int y = 0; y < rows-1; y++) {
   beginShape(TRIANGLE_STRIP);
   for(int x = 0; x < cols; x++) {
    
     vertex(x*scl, y*scl, terrain[x][y]);
     vertex(x*scl, (y+1)*scl, terrain[x][y+1]); 
   }
   endShape();
 }
  
}
