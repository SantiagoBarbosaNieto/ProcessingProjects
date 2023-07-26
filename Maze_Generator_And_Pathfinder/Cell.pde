

class Cell {
  int i, j;
  boolean[] walls = {true, true, true, true};
  boolean visited = false;
  
  Cell previous;
  
  int f = 0;
  int g = 0;
  int h = 0;
  
  
        
  
  Cell(int ii, int jj) {
    i = ii;
    j = jj;
  }

  Cell checkNeighbors() {
    ArrayList<Cell> neighbors = new ArrayList<Cell>();

    Cell top    = grid.get(index(i, j-1));
    Cell right  = grid.get(index(i+1, j));
    Cell bottom = grid.get(index(i, j+1));
    Cell left   = grid.get(index(i-1, j));

    if (top != null && !top.visited && j != 0) {
      neighbors.add(top);
    }
    if (right != null && !right.visited && i != cols-1) {
      neighbors.add(right);
    }
    if (bottom != null && !bottom.visited && j != rows-1) {
      neighbors.add(bottom);
    }
    if (left != null && !left.visited && i != 0) {
      neighbors.add(left);
    }

    if (neighbors.size() > 0) {
      int r = floor(random(0, neighbors.size()));
      return neighbors.get(r);
    } else {
      return null;
    }
  }
  
  ArrayList<Cell> getNeighbors()
  {
    ArrayList<Cell> neighbors = new ArrayList<Cell>();
  
    Cell top    = grid.get(index(i, j-1));
    Cell right  = grid.get(index(i+1, j));
    Cell bottom = grid.get(index(i, j+1));
    Cell left   = grid.get(index(i-1, j));
  
    if (top != null && j != 0) {
      neighbors.add(top);
    }
    if (right != null && i != cols-1) {
      neighbors.add(right);
    }
    if (bottom != null && j != rows-1) {
      neighbors.add(bottom);
    }
    if (left != null && i != 0) {
      neighbors.add(left);
    }
    return neighbors;
  }
  
  void highlight() {
    int x = this.i*w;
    int y = this.j*w;
    noStroke();
    fill(0, 0, 255, 100);
    rect(x, y, w, w);

  }

  void show(color c) {
    int x = this.i*w;
    int y = this.j*w;
    
    if (this.visited) {
      noStroke();
      fill(c);
      rect(x, y, w, w);
    }
    stroke(255);
    strokeWeight(2);
    if (this.walls[0]) {
      line(x    , y    , x + w, y);
    }
    if (this.walls[1]) {
      line(x + w, y    , x + w, y + w);
    }
    if (this.walls[2]) {
      line(x + w, y + w, x    , y + w);
    }
    if (this.walls[3]) {
      line(x    , y + w, x    , y);
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
  
  public void drawCircle(color c, float extra)
  {
    if(extra > 0.4) extra = 0.4;
    int xPix = floor((i*w)+w/2);
    int yPix = floor((j*w)+w/2);
    print("X;Y " + xPix + " " + yPix + "\n");
    stroke(255);
    strokeWeight(1);
    fill(c);
    circle(xPix, yPix, w *(0.5+extra));
  }
}
