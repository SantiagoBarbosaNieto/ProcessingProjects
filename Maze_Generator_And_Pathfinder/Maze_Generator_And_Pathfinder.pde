int cols, rows;
int w = 30;
ArrayList<Cell> grid = new ArrayList<Cell>();

Cell current;
boolean generated = false;

ArrayList<Cell> stack = new ArrayList<Cell>();

Pathfinder pathfinder;

color visited = color(30,10,55);

void setup() {
  size(600, 700);
  reset();

}


void draw() {
  if(!generated)
  {
    background(51);
    generateMaze(); 
  }
  else if(generated && !pathfinder.finished)
  {
     pathfinder.updatePathFinding();
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

void generateMaze()
{
  for (int i = 0; i < grid.size(); i++) {
    grid.get(i).show(visited);
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
  else if(!generated)
  {
    InitPathfinder();
    generated = true;
  }
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

void InitPathfinder()
{
  pathfinder.initPathFinding();
}

void reset()
{
    cols = floor(width/w);
    rows = floor(height/w);
    grid = new ArrayList<Cell>();
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        Cell cell = new Cell(i, j);
        grid.add(cell);
      }
    }
  generated = false;
    current = grid.get(0);
    pathfinder = new Pathfinder((int)random(0, floor(grid.size()/2)), (int)random(floor(grid.size()/2), grid.size()-1));
}
