
import java.util.ArrayList;

int gridSize = 4;
Game g;
GUI gui;
float lastMY = 0;
float lastMX = 0;
ArrayList<Integer> colors;
PVector offset;



void setup()
{
  size(600,900);
  orientation(PORTRAIT);
  frameRate(60);
  
  
  colors = new ArrayList<Integer>();
  colors.add(#414244); //Background Initial
  colors.add(#93A8AC); //Value 2  
  colors.add(#33658A); //Vlaue 4
  colors.add(#314B59); //Vlaue 8 315659
  colors.add(#011638); //Vlaue 16
  colors.add(#446D4F); //Vlaue 32
  colors.add(#003108); //Vlaue 64
  colors.add(#03600F); //Vlaue 128
  colors.add(#21073C); //Vlaue 256
  colors.add(#7353BA); //Vlaue 512
  colors.add(#408C8A); //Vlaue 1024
  colors.add(#A33B20); //Vlaue 2048
  colors.add(#5A352A); //Vlaue 4096
  colors.add(#0FDB6C); //Vlaue 8192
  colors.add(#0F9CDB); //Vlaue 16384
  colors.add(#0F33DB); //Vlaue 32768
  colors.add(#B200FA); //Vlaue 65536
  colors.add(#686868); //TilesBackground index 17
  
  gui = new GUI(colors);
  

  
}



void draw()
{
  background(#303030);
  
  gui.show();
  
}


void mousePressed()
{
  lastMY = mouseY;
  lastMX = mouseX;
  
  if(gui.checkBoundaries(mouseX,mouseY) == "Reset")
   {
     println("Button pressed");
     g = new Game(offset, colors);
   }
    
}

void mouseReleased()
{
  if(g.allArrived())
    {
      g.couldM = false;
      lastMY -= mouseY;
      lastMX -= mouseX;
      if(abs(lastMY) > 10 || abs(lastMX) > 10)
      {
        if(abs(lastMY) > abs(lastMX))
        {
           //Movimiento vertical 
           if(lastMY > 0)
           {
             println("UP");
             g.move(new PVector(0,-1));
           }
           else
           {
             println("DOWN");
             g.move(new PVector(0,1));
           }
        }
        else
        {
            //Movimiento horizontal
            if(lastMX > 0)
           {
             println("LEFT");
             g.move(new PVector(-1,0));
           }
           else
           {
             println("RIGHT");
             g.move(new PVector(1,0));
           }
            
        }
      }
    }
  
}



void keyPressed()
{
  if(g.allArrived())
  {
    g.couldM = false;
    if(keyCode == UP)
    {
      println("UP");
     g.move(new PVector(0,-1));
     println("UP");
    }
    else if(keyCode == DOWN)
    {
     g.move(new PVector(0,1));
     println("DOWN");
    }
    else if(keyCode == RIGHT)
    {
     g.move(new PVector(1,0));
     println("RIGHT");
    }
    else if(keyCode == LEFT)
    {
     g.move(new PVector(-1,0));
     println("LEFT");
    }
  }
}
