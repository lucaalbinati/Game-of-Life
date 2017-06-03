//==================================================================================

Grid grid;

int sizeOfGrid = 80;
int evolutionCounter = 0;
int evolutionSpeed = 11;

ArrayList<Cell> initialCellArray;

boolean setupPhase = true;
boolean paused = false;

int buttonColor = #808587;
Button done_button;
Button pause_button;
Button speed_down_button;
Button speed_up_button;

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

  done_button = new Button(820, 550, 90, 50);
  pause_button = new Button(820, 490, 128, 50);
  speed_down_button = new Button(820, 560, 175, 50);
  speed_up_button = new Button(1017, 560, 128, 50);
}

void draw() {
  background(240, 240, 240);
  grid.display();

  if (!setupPhase && !paused && evolutionCounter == 0) {
    grid.update();
  }

  draw_interface();
  
  if (evolutionCounter >= evolutionSpeed) evolutionCounter = 0;
  else evolutionCounter += 1;
}

void draw_interface() {
  draw_buttons();
  draw_text();
}

void draw_text() {
  textSize(32);
  fill(0);
  text("Game of Life", 820, 45);
  textSize(20);
  text("Description", 820, 130);
  textSize(14);
  text("Conway's Game of Life:\n" +
    "At every new frame, each cell gives birth to the next generation,\n" +
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
    textSize(22);
    text("DONE", 833, 584);
  } else {
    textSize(20);
    text("Controls", 820, 450);
    textSize(22);
    if (paused) text("UNPAUSE", 834, 524);
    else text("PAUSE", 848, 524);
    text("SPEED DOWN", 837, 594);
    text("SPEED UP", 1031, 594);
    
    textSize(20);
    text("Activity", 820, 690);
    textSize(14);
    text("Population : " + grid.getPopulation(), 820, 720);
    text("Evolution Speed : " + convert_speed(evolutionSpeed), 820, 739);
  }
  noFill();
}

void draw_buttons() {
  if (setupPhase) {
    done_button.display();
  } else {
    pause_button.display();
    speed_down_button.display();
    speed_up_button.display();
  }
}

//==================================================================================
//==================================================================================
//==================================================================================

void mouseClicked() {
  if (setupPhase) {
    if (mouseX < 800) {
      int xCoord = (int) map(mouseX, 0, height, 0, sizeOfGrid);
      int yCoord = (int) map(mouseY, 0, height, 0, sizeOfGrid);
      grid.bringLifeOrDeath(xCoord, yCoord);
    } else {
      if (done_button.containsCoord(mouseX, mouseY)) {
        setupPhase = false;
      }
    }
  } else {
    if (pause_button.containsCoord(mouseX, mouseY)) {
      paused = !paused;
    }
    if (speed_down_button.containsCoord(mouseX, mouseY)) {
      evolutionSpeed = min(30, evolutionSpeed + 1);
    }
    if (speed_up_button.containsCoord(mouseX, mouseY)) {
      evolutionSpeed = max(1, evolutionSpeed - 1);
    }
  }
}

//==================================================================================
//==================================================================================
//==================================================================================

int compute_index(int x, int y) {
  return y * sizeOfGrid + x;
}

int convert_speed(int evolSpeed) {
  return 31 - evolSpeed;
}

//==================================================================================