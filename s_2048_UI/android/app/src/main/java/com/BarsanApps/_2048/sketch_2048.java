package com.BarsanApps._2048;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import interfascia.*; 
import java.util.ArrayList; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_2048 extends PApplet {






int gridSize = 4;
Game g;
GUI gui;
float lastMY = 0;
float lastMX = 0;
ArrayList<Integer> colors;
PVector offset;



public void setup()
{
  //size(500,700);
  orientation(PORTRAIT);
  frameRate(60);
  
  
  colors = new ArrayList<Integer>();
  colors.add(0xff414244); //Background Initial
  colors.add(0xff93A8AC); //Value 2  
  colors.add(0xff33658A); //Vlaue 4
  colors.add(0xff314B59); //Vlaue 8 315659
  colors.add(0xff011638); //Vlaue 16
  colors.add(0xff446D4F); //Vlaue 32
  colors.add(0xff003108); //Vlaue 64
  colors.add(0xff03600F); //Vlaue 128
  colors.add(0xff21073C); //Vlaue 256
  colors.add(0xff7353BA); //Vlaue 512
  colors.add(0xff408C8A); //Vlaue 1024
  colors.add(0xffA33B20); //Vlaue 2048
  colors.add(0xff5A352A); //Vlaue 4096
  colors.add(0xff4C212A); //Vlaue 8192
  colors.add(0xff0F9CDB); //Vlaue 16384
  colors.add(0xff0F33DB); //Vlaue 32768
  colors.add(0xffB200FA); //Vlaue 65536
  colors.add(0xff686868); //TilesBackground index 17
  
  gui = new GUI(colors);
  

  
}



public void draw()
{
  background(0xff303030);
  
  gui.show();
  
}


public void mousePressed()
{
  lastMY = mouseY;
  lastMX = mouseX;
  
  if(gui.checkBoundaries(mouseX,mouseY) == "Reset")
   {
     println("Button pressed");
     g = new Game(offset, colors);
   }
    
}

public void mouseReleased()
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

public void mouseMoved()
{
  
}


public void keyPressed()
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
class Button{
  
  PVector pos;
  PVector tam;
  int col;
  private String action;
  Button(int x, int y, int w, int h, int col, String action)
  {
    pos = new PVector(x,y);
    tam = new PVector(w,h);
    this.col = col;
    this.action = action;
  }
  
  public void show()
  {
    fill(color(col));
    rect(pos.x,pos.y,tam.x,tam.y, tam.x/10);
    fill(10);
    textAlign(CENTER,CENTER);
    textSize(this.tam.y*3/5);
    text(this.action,this.pos.x + this.tam.x/2, this.pos.y + this.tam.y/2 - 5);
  }
  
  public String getAction()
  {
    return this.action;
  }



}
class GUI{
  
  ArrayList<Button> btns;
  ArrayList<Integer> colors;

  Button btnReset;
  
  GUI(ArrayList<Integer> colors)
  {
    this.colors = colors;
    btns = new ArrayList<Button>();
    
    offset = new PVector(30,height*20/100);
    
    g = new Game(offset, colors);
    
    btnReset = new Button(10,40 + PApplet.parseInt(height-(height-width-offset.y)), 300, 150, colors.get(0), "Reset");
    btns.add(btnReset);
 }
  
 public void show()
 {
   g.show();
   btnReset.show();
 }
  
 public void update()
 {
   
 }
 
 
 public String checkBoundaries(int x, int y)
 {
   for(Button btn: btns)
   {
     
     if((x > btn.pos.x && x < btn.pos.x + btn.tam.x)&& (y > btn.pos.y && y < btn.pos.y + btn.tam.y))
     {
       return btn.getAction();
     }
   }
   
   return "NONE";
   
 }
  
}
class Game{

  ArrayList<Tile> tiles = new ArrayList<Tile>();
  ArrayList<Tile> toRemove = new ArrayList<Tile>();
  
  boolean[][] grid = new boolean[gridSize][gridSize];
  Tile[][] tilesGrid = new Tile[gridSize][gridSize];
  Tile[][] newTilesGrid = new Tile[gridSize][gridSize];
  
  PVector vel = new PVector(0.5f,0.5f);
  PVector lastDir;
 
  boolean moving;
  boolean couldM;
  
  PVector gameOffset;
  
  int score;
  int s = 0xff5C8E76;
  ArrayList<Integer> colors;
  
  float spacing = width/100;
  float tileSize;
 
  Game(PVector gameOffset, ArrayList<Integer> colors)
  {
    this.colors = colors;
    this.gameOffset = gameOffset;
    tileSize = (width-gameOffset.x*2-(spacing*(gridSize+1)))/gridSize;
    score = 0;
    for(int y = 0; y < gridSize; y++)
    {
      for(int x = 0; x <gridSize; x++)
      {
        grid[x][y] = true;

      }
    }
    newTile();
    newTile();
    
    moving = false;
    couldM = false;
  }
  
  public void show()
  {
    
    fill(color(colors.get(0)));
    rect(gameOffset.x,gameOffset.y, width- offset.x*2,width-offset.x*2,width/100);
    
    for(int i = 0; i < gridSize; i++)
    {
      for(int j = 0; j < gridSize; j++)
      {
        fill(color(colors.get(17)));
        rect(spacing + j*spacing + j*tileSize + gameOffset.x, spacing + i*spacing + i*tileSize + gameOffset.y, tileSize, tileSize, tileSize/10 ); 
      }
    }
    
    if(!moving)
    {
     for(Tile t: tiles)
     {
       t.show();
     }
    
    }
    else if(moving)
    {
      for(Tile t: tiles)
      {
        if(t.destination.x != t.position.x || t.destination.y != t.position.y)
        {
          t.position.x += (vel.x * lastDir.x);
          t.position.y += (vel.y * lastDir.y);
        }
        t.show();
      }
      
      if(allArrived())
      {
       moving = false;
       for(Tile t: toRemove)
       {
         if(t != null)
         score += pow(2,t.merges+1);
         tiles.remove(t);
       }
       toRemove.clear();

       if(couldM)
       newTile();
      }
    }
    fill(255);
    textAlign(CENTER,CENTER);
    textSize(gameOffset.y*3/5);
    //println(size);
    textAlign(LEFT,BOTTOM);
    text("2048", gameOffset.x, gameOffset.y- gameOffset.y*1/5);
    
    textAlign(LEFT, BOTTOM);
    textSize(gameOffset.y*1/5);
    text("Score: "+ score, 10+ gameOffset.x, gameOffset.y);
  }//CLOSE SHOW

  public void newTile()
  {
      int x = (int)Math.floor(Math.random()*(gridSize-0.1f));
      int y = (int)Math.floor(Math.random()*(gridSize-0.1f));
     while(!grid[x][y])
     {

      x = (int)Math.floor(Math.random()*(gridSize-0.1f));
      y = (int)Math.floor(Math.random()*(gridSize-0.1f));
     }

     PVector vect = new PVector(x,y);
     Tile newTile = new Tile((int)vect.x,(int)vect.y, gameOffset, colors, spacing, tileSize);
     tiles.add(newTile);
     tilesGrid[(int)vect.x][(int)vect.y] = newTile;
     grid[(int)vect.x][(int)vect.y] = false;
  }
  
  
     
  public void move(PVector dir)
  {
    lastDir = dir;
    ArrayList<Tile> t = new ArrayList<Tile>();
    
    //-------Se organizan dependiendo de la direccion en la que se van a mover
    if(dir.x == 0 && dir.y == 1) //DOWN
    {
      for(int y = gridSize-1; y >= 0; y--)
      {
        for( int x = 0; x < gridSize; x++)
        {
          if(tilesGrid[x][y] != null)
          {
            t.add(tilesGrid[x][y]);
            println(tilesGrid[x][y].position, x, y);
          }
        }
      }
    }
    else if(dir.x == 0 && dir.y == -1) //UP
    {
     for(int y = 0; y < gridSize; y++)
      {
        for( int x = 0; x < gridSize; x++)
        {
          if(tilesGrid[x][y] != null)
          {
            t.add(tilesGrid[x][y]);
          }
        }
      } 
    }
    else if(dir.x == 1 && dir.y == 0) //RIGHT
    {
      for(int x =gridSize-1; x >= 0; x--)
      {
        for( int y = 0; y < gridSize; y++)
        {
          if(tilesGrid[x][y] != null)
          {
            t.add(tilesGrid[x][y]);
          }
        }
      }
    }
    else if(dir.x == -1 && dir.y == 0) //LEFT
    {
      for(int x = 0; x < gridSize; x++)
      {
        for( int y = 0; y < gridSize; y++)
        {
          if(tilesGrid[x][y] != null)
          {
            t.add(tilesGrid[x][y]);
          }
        }
      }
    }
    //-------Ya estan organizadas en Array t para la direccion de movimiento
    
    for(Tile ti: t)
    {
      PVector newPos = calcPos(ti, dir);
      newTilesGrid[(int)newPos.x][(int)newPos.y] = ti;
    }
    moving = true;
  } //CLOSE MOVE
  
  public PVector calcPos(Tile t, PVector dir)
  {
    PVector newPos = new PVector(t.position.x,t.position.y);
    boolean space = true;
    if(dir.x != 0  || dir.y != 0) //X AXIS
    {
      while(space && newPos.x + dir.x >= 0 && newPos.x + dir.x <= gridSize-1 && newPos.y + dir.y >= 0 && newPos.y + dir.y <= gridSize-1)
      {
        
        //Se valida si hay espacio un cuadro hacia donde se mueve
        boolean hayS = grid[(int)(newPos.x+dir.x)][(int)(newPos.y + dir.y)];
        
       if(tilesGrid[(int)(newPos.x+dir.x)][(int)(newPos.y + dir.y)] != null)
       {
         if(tilesGrid[(int)(newPos.x+dir.x)][(int)(newPos.y + dir.y)].value == t.value 
             && !tilesGrid[(int)(newPos.x+dir.x)][(int)(newPos.y + dir.y)].willMerge)
         {

           t.willMerge = true;
           hayS = true;
         }
       }
        
        if(hayS)
        {
         grid[(int)(newPos.x)][(int)newPos.y] = true;
         tilesGrid[(int)(newPos.x)][(int)newPos.y] = null;
         newPos.add(dir);
         grid[(int)newPos.x][(int)newPos.y] = false;
         toRemove.add(tilesGrid[(int)(newPos.x)][(int)newPos.y]);
         tilesGrid[(int)(newPos.x)][(int)newPos.y] = t;
         couldM = true;
        }
        else
        {
          space = false; 
        }
      }
    }
     t.destination.x = newPos.x;
     t.destination.y = newPos.y;
    return newPos;
  } //CLOSE CALCPOS
  
  public boolean allArrived()
  {
   for(Tile t: tiles)
   {
     
     if(t.destination.x == t.position.x && t.destination.y == t.position.y)
     {
       if(t.willMerge)
         {
            t.willMerge = false;
            t.merges++;
            t.update();
         }
     }
    if(t.destination.x != t.position.x || t.destination.y != t.position.y)
    {
      return false;
    }
   }
    return true;
  }
  
}//CLOSE CLASS
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
  
  int c;
  int cT;
  
  ArrayList<Integer> colors;
  
  Tile(int x, int y, PVector offset, ArrayList<Integer> colors, float spacing, float size)
  {
    this.spacing = spacing;
    this.colors = colors;
    if(random(1) < 0.1f){
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
  
  
  public void update()
  {
    value = (int)pow(2,merges);
    c = color(colors.get(merges));
   if(value == 2)
   {
     cT = color(0);
   }
   else if(value == 4)
   {
     cT = color(0);
   }
   else if(value == 8)
   {
     cT = color(255);
   }
   else if(value == 16)
   {
     cT = color(255);
   }
   else if(value == 32)
   {
     cT = color(255);
   }
   else if(value == 64)
   {
     cT = color(255);
   }
   else if(value == 128)
   {
     cT = color(255);
   }
   else if(value == 256)
   {
     cT = color(255);
     c = color(colors.get(merges));
   }
   else if(value == 512)
   {
     cT = color(255);
   }
   else if(value == 1024)
   {
     cT = color(255);
   }
   else if(value == 2048)
   {
     cT = color(255);
   }
   else if(value == 4096)
   {
     cT = color(255);
   }
   else if(value == 8192)
   {
     cT = color(255);
     c = color(0xff0FDB6C);
   }
   else if(value == 16384)
   {
     cT = color(255);
   }
   else if(value == 32768)
   {
     cT = color(255);
   }
   else if(value == 65536)
   {
     cT = color(255);
   }
   else
   {
    cT = color(255);
    c = color(0);
   }
   
    
  }
  
  
  
  public void show(){
    pixelPos = new PVector(spacing + position.x*spacing + position.x*size + offset.x, spacing + position.y*spacing + position.y*size + offset.y);
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
}
