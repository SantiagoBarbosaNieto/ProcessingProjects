class Tile{
  int value;
  PVector position;
  PVector destination; 
  PVector pixelPos;//Top Left
  float size;
  float spacing = width/100;
  
  boolean willMerge;
  int merges;
  
  color c;
  color cT;
  
  Tile(int x, int y)
  {
    if(random(1) < 0.1){
      merges = 2;
    } else {
     merges = 1; 
    }
    size = (width-(spacing*(gridSize+1)))/gridSize;
    position = new PVector(x,y);
    destination = new PVector (position.x, position.y);
    pixelPos = new PVector(spacing + position.x*spacing + position.x*size, spacing + position.y*spacing + position.y*size);
    println(pixelPos);
    willMerge = false;
    update();
  }
  
  
  void update()
  {
    value = (int)pow(2,merges);
   if(value == 2)
   {
     cT = color(0);
     c = color(#E8E5BE);
   }
   else if(value == 4)
   {
     cT = color(0);
     c = color(#CEE393);
   }
   else if(value == 8)
   {
     cT = color(255);
     c = color(#F58B19);
   }
   else if(value == 16)
   {
     cT = color(255);
     c = color(#F77939);
   }
   else if(value == 32)
   {
     cT = color(255);
     c = color(#F5521B);
   }
   else if(value == 64)
   {
     cT = color(255);
     c = color(#F53D19);
   }
   else if(value == 128)
   {
     cT = color(255);
     c = color(#EACA24);
   }
   else if(value == 256)
   {
     cT = color(255);
     c = color(#E0BC05);
   }
   else if(value == 512)
   {
     cT = color(255);
     c = color(#C9A906);
   }
   else if(value == 1024)
   {
     cT = color(255);
     c = color(#DEBD19);
   }
   else if(value == 2048)
   {
     cT = color(255);
     c = color(#DBBA0F);
   }
   else if(value == 4096)
   {
     cT = color(255);
     c = color(#93DB0F);
   }
   else if(value == 8192)
   {
     cT = color(255);
     c = color(#0FDB6C);
   }
   else if(value == 16384)
   {
     cT = color(255);
     c = color(#0F9CDB);
   }
   else if(value == 32768)
   {
     cT = color(255);
     c = color(#0F33DB);
   }
   else if(value == 65536)
   {
     cT = color(255);
     c = color(#B200FA);
   }
   else
   {
    cT = color(255);
    c = color(0);
   }
   
    
  }
  
  
  
  void show(){
    pixelPos = new PVector(spacing + position.x*spacing + position.x*size, spacing + position.y*spacing + position.y*size);
    fill(c);
    noStroke();
    rect(pixelPos.x,pixelPos.y,size,size, size/10);
    fill(cT);
    textAlign(CENTER,CENTER);
    textSize(size/4);
    //println(size);
    text(value, pixelPos.x + size/2, pixelPos.y + size/2);
  }
}
