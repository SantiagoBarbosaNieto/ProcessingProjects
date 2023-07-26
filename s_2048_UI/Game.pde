class Game{

  ArrayList<Tile> tiles = new ArrayList<Tile>();
  ArrayList<Tile> toRemove = new ArrayList<Tile>();
  
  boolean[][] grid = new boolean[gridSize][gridSize];
  Tile[][] tilesGrid = new Tile[gridSize][gridSize];
  Tile[][] newTilesGrid = new Tile[gridSize][gridSize];
  
  PVector vel = new PVector(0.5,0.5);
  PVector lastDir;
 
  boolean moving;
  boolean couldM;
  
  PVector gameOffset;
  
  int score;
  int s = #5C8E76;
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
    //newTile();
    newTile();
    
    moving = false;
    couldM = false;
  }
  
  void show()
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

  void newTile()
  {
      int x = (int)Math.floor(Math.random()*(gridSize-0.1));
      int y = (int)Math.floor(Math.random()*(gridSize-0.1));
     while(!grid[x][y])
     {

      x = (int)Math.floor(Math.random()*(gridSize-0.1));
      y = (int)Math.floor(Math.random()*(gridSize-0.1));
     }

     PVector vect = new PVector(x,y);
     Tile newTile = new Tile((int)vect.x,(int)vect.y, gameOffset, colors, spacing, tileSize);
     tiles.add(newTile);
     tilesGrid[(int)vect.x][(int)vect.y] = newTile;
     grid[(int)vect.x][(int)vect.y] = false;
  }
  
  
     
  void move(PVector dir)
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
  
  PVector calcPos(Tile t, PVector dir)
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
  
  boolean allArrived()
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
