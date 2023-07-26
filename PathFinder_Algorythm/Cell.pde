class Cell {

int x;
int y;
int f = 0;
int g = 0;
int h = 0;
Cell previous;
boolean wall = false;

void setWall(float chance) {
if(random(0,1) < chance ) 
{
  wall = true; 
}
}
ArrayList<Cell> neighbors = new ArrayList<Cell>(); 
void setC( int i, int j) {
  x = i;
  y = j;
}

void show(color c) {
   
  fill(c);
  
  if(wall)
  {
    fill(0);
  }
  
  noStroke();
  rect(x * wi,y * he,wi -1 ,he -1);
  
  
  }
  
  void addNeighbors() {
    int i = x;
    int j = y;
    
    if(i < cols -1) {
     neighbors.add(grid[i + 1][j  ]);
    }
    if(i >0) {
     neighbors.add(grid[i - 1][j  ]);
    }
    if(j < rows -1) {
     neighbors.add(grid[i    ][j + 1]);
    }
    if(j > 0) {
     neighbors.add(grid[i    ][j - 1]); 
    }
    
  }
  
  
  boolean hasPrevious()
  {
    if(previous != null)
    {
      return true;
    } else
    {
     return false; 
    }
  }
}
