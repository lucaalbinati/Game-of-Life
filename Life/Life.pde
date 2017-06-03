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
  size(1100, 800, P2D);
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