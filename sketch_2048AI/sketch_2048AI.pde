int gridSize = 4;
Game g;
void setup()
{
  size( 500, 500);
  //frameRate(4);
  g = new Game();
 
}

void draw()
{
  background(0);
  
  g.show();
  
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
