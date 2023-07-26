class Tile{
  int value;
  PVector position;
  PVector destination; 
  PVector pixelPos;//Top Left
  PVector offset;
  float size;
  float spacing = width/100;
  
  boolean willMerge;
  int merges;
  
  color tileColor;
  color textColor;
  
  ArrayList<Integer> colors;
  
  Tile(int x, int y, PVector offset, ArrayList<Integer> colors, float spacing, float size)
  {
    this.spacing = spacing;
    this.colors = colors;
    if(random(1) < 0.1){
      merges = 2;
    } else {
     merges = 1; 
    }
    this.offset = offset;
    this.size = size;
    position = new PVector(x,y);
    destination = new PVector (position.x, position.y);
    pixelPos = new PVector(spacing + position.x*spacing + position.x*size + offset.x, spacing + position.y*spacing + position.y*size + offset.y);
    println(pixelPos);
    willMerge = false;
    update();
  }
  
  
  void update()
  {
    value = (int)pow(2,merges);
    tileColor = color(colors.get(merges));
   if(value == 2)
   {
     textColor = color(0);
   }
   else if(value == 4)
   {
     textColor = color(0);
   }
   else if(value == 8)
   {
     textColor = color(255);
   }
   else if(value == 16)
   {
     textColor = color(255);
   }
   else if(value == 32)
   {
     textColor = color(255);
   }
   else if(value == 64)
   {
     textColor = color(255);
   }
   else if(value == 128)
   {
     textColor = color(255);
   }
   else if(value == 256)
   {
     textColor = color(255);
   }
   else if(value == 512)
   {
     textColor = color(255);
   }
   else if(value == 1024)
   {
     textColor = color(255);
   }
   else if(value == 2048)
   {
     textColor = color(255);
   }
   else if(value == 4096)
   {
     textColor = color(255);
   }
   else if(value == 8192)
   {
     textColor = color(255);
   }
   else if(value == 16384)
   {
     textColor = color(255);
   }
   else if(value == 32768)
   {
     textColor = color(255);
   }
   else if(value == 65536)
   {
     textColor = color(255);
   }
   else
   {
    textColor = color(255);
    tileColor = color(0);
   }
   
    
  }
  
  
  
  void show(){
    pixelPos = new PVector(spacing + position.x*spacing + position.x*size + offset.x, spacing + position.y*spacing + position.y*size + offset.y);
    fill(tileColor);
    noStroke();
    rect(pixelPos.x,pixelPos.y,size,size, size/10);
    fill(textColor);
    textAlign(CENTER,CENTER);
    textSize(size/4);
    //println(size);
    text(value, pixelPos.x + size/2, pixelPos.y + size/2);
  }
}
