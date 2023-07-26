int cols, rows;
int w = 30;
ArrayList<Cell> grid = new ArrayList<Cell>();

Cell current;

ArrayList<Cell> stack = new ArrayList<Cell>();

void setup() {
  size(1200, 600);
  cols = floor(width/w);
  rows = floor(height/w);
  //frameRate(10);

  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      Cell cell = new Cell(i, j);
      grid.add(cell);
    }
  }

  current = grid.get(0);

}

void draw() {
  background(51);
  for (int i = 0; i < grid.size(); i++) {
    grid.get(i).show();
  }

  
  // STEP 1
  Cell next = current.checkNeighbors();
  if (next != null) {
    
    current.visited = true;
    current.highlight();
    next.visited = true;

    // STEP 2
    stack.add(current);

    // STEP 3
    removeWalls(current, next);

    // STEP 4
    current = next;
  } else if (stack.size() > 0) {
    current.highlight();
    current = stack.remove(stack.size()-1);
  }
  else
  {
    if(mousePressed)
    {
      reset();
    }
  }

}

int index(int i, int j) {
  if (i < 0 || j < 0 || i > cols-1 || j > rows-1) {
    return 0;
  }
  return i + j * cols;
}

void reset()
{
  grid = new ArrayList<Cell>();
  stack = new ArrayList<Cell>();
  
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      Cell cell = new Cell(i, j);
      grid.add(cell);
    }
  }
  
  current = grid.get(0);

}

void removeWalls(Cell a, Cell b) {
  int x = a.i - b.i;
  if (x == 1) {
    a.walls[3] = false;
    b.walls[1] = false;
  } else if (x == -1) {
    a.walls[1] = false;
    b.walls[3] = false;
  }
  int y = a.j - b.j;
  if (y == 1) {
    a.walls[0] = false;
    b.walls[2] = false;
  } else if (y == -1) {
    a.walls[2] = false;
    b.walls[0] = false;
  }
}
