Population test;
PVector goal1  = new PVector(400, 10);
PVector goal2 = new PVector(160, 400);


void setup() {
  size(800, 800); //size of the window
  frameRate(100);//increase this to make the dots go faster
  test = new Population(1000);//create a new population with 1000 members
}


void draw() { 
  background(255);
  fill(0);
  textSize(20);
  text("Generation: "+ test.gen, 10, 25 );
  text("Step: " + test.minStep, 10, 45);
  //draw goal
  fill(255, 0, 0);
  ellipse(goal1.x, goal1.y, 10, 10);
  ellipse(goal2.x, goal2.y, 10, 10);

  //draw obstacle(s)
  fill(0, 0, 255);

  rect(0, 200, 600, 10);
  
  rect(300, 400, 500, 10);
  
  rect(0, 600, 500, 10);


  if (test.allDotsDead()) {
    //genetic algorithm
    test.calculateFitness();
    test.naturalSelection();
    test.mutateDemBabies();
  } else {
    //if any of the dots are still alive then update and then show them

    test.update();
    test.show();
  }
}
