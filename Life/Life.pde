//==================================================================================

Grid grid;

int sizeOfGrid = 80;

ArrayList<Cell> initialCellArray;

boolean setupPhase = true;
boolean paused = false;

//==================================================================================
//==================================================================================
//==================================================================================

void setup() {
  size(1300, 800, P2D);
  frameRate(60);
  stroke(#e0fffc);

  initialCellArray = new ArrayList();
  for (int row = 0; row < sizeOfGrid; ++row) {
    for (int col = 0; col < sizeOfGrid; ++col) {
      initialCellArray.add(new Cell(col, row, false));
    }
  }
  grid = new Grid(sizeOfGrid, sizeOfGrid, initialCellArray);
}

void draw() {
  if (!paused) {
    background(240, 240, 240);
    grid.display();
  }
  if (!setupPhase) {
    grid.update();
  }
  draw_interface();
}

void draw_interface() {
  textSize(32);
  fill(0);
  text("Game of Life", 820, 45);
  textSize(20);
  text("Description", 820, 130);
  textSize(14);
  text("Conway's Game of Life:\n" +
       "At every new frame, each cells gives birth to the next generation,\n" +
       "according to these 4 simple rules:\n" +
       "1. Any live cell with fewer than two live neighbours dies, as if caused\n" +
       "by underpopulation.\n" +
       "2. Any live cell with two or three live neighbours lives on to the next\n" +
       "generation.\n" +
       "3. Any live cell with more than three live neighbours dies, as if by\n" +
       "overpopulation.\n" +
       "4. Any dead cell with exactly three live neighbours becomes a live\n" +
       "cell, as if by reproduction.", 820, 160);
       
  if (setupPhase) {
    textSize(20);
    text("Setup Phase", 820, 450);
    textSize(14);
    text("Click on any cell to bring to life, or to kill it.\n" +
         "Once you are satisified with the initial state, press\n" +
         "any of the arrow key.", 820, 480);
  } else {
    textSize(20);
    text("Controls", 820, 450);
  }
  noFill();
}

//==================================================================================
//==================================================================================
//==================================================================================

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT) {
      setupPhase = false;
      frameRate(3);
    }
    if (keyCode == 80) {
      paused = !paused;
      println("here");
    }
  }
}

void mouseClicked() {
  if (setupPhase) {
    int xCoord = (int) map(mouseX, 0, height, 0, sizeOfGrid);
    int yCoord = (int) map(mouseY, 0, height, 0, sizeOfGrid);

    grid.bringLifeOrDeath(xCoord, yCoord);
  }
}

//==================================================================================
//==================================================================================
//==================================================================================

int compute_index(int x, int y) {
  return y * sizeOfGrid + x;
}

//==================================================================================