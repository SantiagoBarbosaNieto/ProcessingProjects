//_______________________________________________________________________________
//Atributos Globales
//-------------------------------------------------------------------------------

int cols = 50;

int rows = 50;

int he, wi;

Cell[][] grid = new Cell[cols][rows];

Cell current;

ArrayList<Cell> path = new ArrayList<Cell>();

ArrayList<Cell> openSet = new ArrayList<Cell>();

ArrayList<Cell> closedSet = new ArrayList<Cell>();

Cell start;

Cell end;

boolean ended = true;

//____________________________________________________________________________
//SETUP
//----------------------------------------------------------------------------
void setup() {
  //Canvas
  size(400, 400);
  //"Time" speed
  //frameRate(15);
  
  //Height of a Cell
  he = height/rows; 
  //Width of a Cell
  wi = width/cols;

  reset();
}


//______________________________________________________________________________
//DRAW
//------------------------------------------------------------------------------
void draw() {
  
 
  
  if(ended)
  {
    if(mousePressed)
    {
      reset();
    }
  }
  else
  {
    background(0);
    
    cuerpoAlgoritmo();
  
    //Crea el mejor camino actualmente evaluado 
    makePath();
        
    //Pinta los Cells de la grid dependiendo de su estado
    drawGrid();
    
    //Forma una linea blanca por el camino evaluado
    drawLine();
  }
  
  
}

//________________________________________________________________________________
//Métodos
//--------------------------------------------------------------------------------

void reset()
{
  
    path = new ArrayList<Cell>();

    openSet = new ArrayList<Cell>();

    closedSet = new ArrayList<Cell>();
    //Se crean los Cells de la grid, se les asigna un x & un y, 
    //se define si van a ser paredes o no 
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j] = new Cell();
        grid[i][j].setC(i, j);
        grid[i][j].setWall(0.333);
      }
    }
  
    //Se añade las referencias a los Cells vecinos de cada Cell de la grid
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j].addNeighbors();
      }
    }
  
    //Se define el comienzo y el final
    start = grid[0][0];
    end = grid[cols - 1][rows - 1];
    //Se añade el primer elemento que el algoritmo evalua
    openSet.add(start);
    //Previene qu eel inicio y el final sean paredes
    start.wall = false;
    end.wall = false;
    
    ended = false;
}

//El cuerpo del algoritmo calcula el mejor camino dependiendo de los vecinos
//del Cell actual, el camino ya recorrido y una estimacion del camino faltante
void cuerpoAlgoritmo() 
{
  if (openSet.size() > 0)
  {
    //Indice del que tenga mejor puntaje f (El màs bajo)
    int bestI = 0;
    
    //Actualiza el ìndice del mejor 
    for ( int i = 0; i < openSet.size(); i++) {
      if (openSet.get(i).f < openSet.get(bestI).f) {
        bestI = i;
      }
    }
    // Parte del algoritmo se hace sobre el mejor. Variable para rapido uso:
    current =  openSet.get(bestI);
    
    //Si està parado en el final TERMINA
    if (current == end) {
      ended = true;
      println("DONE");
    }
    //Si no es el final remueve el actual de la lista de la lista OpenSet
    //y lo añade a la lista de ya visitados (closedSet)
    openSet.remove(current);
    closedSet.add(current);
    
    //Facil acceso a los vecinos
    ArrayList<Cell> neighbors = current.neighbors;
    Cell currentNeighbor;
    
    //Ciclo que revisa los posibles caminos a tomar por medio de los vecinos
    //de el Cell actual.
    for ( int i = 0; i < neighbors.size(); i++)
    {
      //Actualiza el vecino sobre el cual se va a llevar a cabo el algoritmo
      currentNeighbor = neighbors.get(i);
      //Si no esta en la lista closedSet && no es una pared
      if (!closedSet.contains(currentNeighbor) && !currentNeighbor.wall) 
      {
        //Variable que representa el valor g del vecino actual
        int tempG = current.g + 1;
        //No es parte de un nuevo camino
        boolean newPath = false;
        
        //Si el vecino se encuentra ne la lista openSet
        if (openSet.contains(currentNeighbor)) 
        {
          //Si el g del Cell actual + 1 tiene menor g que el vecino actual
          if (tempG < currentNeighbor.g) 
          {
            //Se actualiza el g del vecino a g del Cell actual +1
            currentNeighbor.g = tempG;
            //Se establece que se encontro un nuevo mejor camino
            newPath = true;
          }
        } 
        //Si el vecino no se encuentra en la lista openSet
        else 
        {
          //Se actualiza el g del vecino por el g del Cell actual + 1 
          //(Puede ser menor o igual que antes) 
          currentNeighbor.g = tempG;
          //Si entro aqui significa que es un nuevo camino
          newPath = true;
          //Se añade este nuevo Cell a la lista openSet
          openSet.add(currentNeighbor);
        }
        
        //Si el vecino actual es un nuevo o mejor camino
        if(newPath) {
          //Se estima la distancia desde este vecino al final (Heuristic)
          currentNeighbor.h = heuristic(currentNeighbor, end);
          //Se calcula el puntaje total f (g + h)
          currentNeighbor.f = currentNeighbor.g + currentNeighbor.h;
          //Se añade el Cell actual como el anterior a su vecino con un buen camino
          currentNeighbor.previous = current;
        }
      }
    }

  } 
  else //Si no quedan elementos en openSet no quedan Cells por revisar
       //y no se ha llegado al final
  { 
    ended = true;
    println("NO HAY SOLUION");
  }
}


//Calcula la distancia estimada (hacia abajo) entre dos Cells de la grid
int heuristic(Cell a, Cell b) {
  int d = abs(b.x - a.x + b.y - a.y);
  return d;
}

//Dibuja una linea por el medio del camino evaluado
void drawLine() {
  beginShape();
  for (int i = 0; i < path.size(); i++) 
  {
    stroke (255);

    if(path.size() > 0) {
   vertex((path.get(i).x * wi) + (wi/2), (path.get(i).y * he) + (he/2));
    noFill();
    }
  }
  endShape();
}

//Dibuja todos los Cells de la grid según su estado
void drawGrid() {
  
  //Se muestran todas las casillas no visitadas nunca 
  //(BLANCO)
  for (int i = 0; i < cols; i ++) {
    for (int j = 0; j < rows; j ++) {
      grid[i][j].show(color(255));
    }
  }
  
  //Se muestran las casillas ya visitadas que no volveran a ser evaluadas 
  //(closedSet - ROJO)
  for ( int i = 0; i < closedSet.size(); i++) {
    closedSet.get(i).show(color(255, 0, 0));
  }

  //Se muestran las casillas visitadas que pueden volver a ser evaluadas 
  //(openSet - VERDE)
  for ( int i = 0; i < openSet.size(); i++) {
    openSet.get(i).show(color(0, 255, 0));
  }
  
  //Pinta los Cells del camino que fue evaluado 
  //(AZUL)
  for (int i = 0; i < path.size(); i++) 
  {
    stroke (255);
    if(path.size() > 0) {
    path.get(i).show(color(0,0,255));

    }
  }
  
  //Si un Cell es un obstaculo, esto no aplicara por un metodo dentor de Cell  
}

//Crea el camino actualmente evaluado
void makePath() { 
  path = new ArrayList<Cell>();
  Cell temp = current;
  path.add(temp);
  //Por recursion añade los Cells que forman parte del camino
  while(temp.hasPrevious())
  {
   path.add(temp.previous);
   temp = temp.previous;
  } 
}
