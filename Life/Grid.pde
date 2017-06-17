class Grid {
  
  private int nbBlocksWidth;
  private int nbBlocksHeight;
  private ArrayList<Cell> cells;
  private ArrayList<Cell> saved_cells;
  
  public Grid(int nbBlocksWidth, int nbBlocksHeight, ArrayList<Cell> initialCells) {
    this.nbBlocksWidth = nbBlocksWidth;
    this.nbBlocksHeight = nbBlocksHeight;
    saved_cells = new ArrayList();
    
    this.cells = new ArrayList();
    for (int row = 0; row < nbBlocksHeight; ++row) {
      for (int col = 0; col < nbBlocksWidth; ++col) {
        Cell c = initialCells.get(row * nbBlocksWidth + col);
        this.cells.add(new Cell(c.getXCoord(), c.getYCoord(), c.getAlive()));
      }
    }
  }
  
  public void bringLife(int xCoord, int yCoord) {
    if ((0 <= xCoord && xCoord < nbBlocksWidth) && (0 <= yCoord && yCoord < nbBlocksHeight)) {
      int index = yCoord * nbBlocksWidth + xCoord;
      cells.set(index, new Cell(xCoord, yCoord, true));
    }
  }
  
  public void bringLifeOrDeath(int xCoord, int yCoord) {
    if ((0 <= xCoord && xCoord < nbBlocksWidth) && (0 <= yCoord && yCoord < nbBlocksHeight)) {
      int index = yCoord * nbBlocksWidth + xCoord;
      Cell c = cells.get(index);
      cells.set(index, new Cell(xCoord, yCoord, !c.getAlive()));
    }
  }
  
  public void update() {
    ArrayList<Cell> newCells = new ArrayList();
    
    for (int row = 0; row < nbBlocksHeight; ++row) {
      for (int col = 0; col < nbBlocksWidth; ++col) {
        int index = row * nbBlocksWidth + col;
        Cell c = cells.get(index);
        
        boolean newAlive = compute_alive(c);
        
        Cell newCell = new Cell(c.getXCoord(), c.getYCoord(), newAlive);
        newCells.add(newCell);
      }
    }
    
    cells = newCells;
  }
  
  public void display() {
    int cellWidth = height / nbBlocksWidth;
    int cellHeight = height / nbBlocksHeight;
    
    for (int row = 0; row < nbBlocksHeight; ++row) {
      for (int col = 0; col < nbBlocksWidth; ++col) {
        Cell cell = cells.get(row * nbBlocksWidth + col);
        
        if (cell.getAlive()) fill(0);
        else fill(255, 255, 255);
        
        rect(cell.getXCoord() * cellWidth, cell.getYCoord() * cellHeight, cellWidth, cellHeight);
        
        noFill();
      }
    }
  }
  
  public void save_current_state() {
    saved_cells.clear();
    
    for (int row = 0; row < nbBlocksHeight; ++row) {
      for (int col = 0; col < nbBlocksWidth; ++col) {
        Cell cell = cells.get(row * nbBlocksWidth + col);
        saved_cells.add(new Cell(cell.getXCoord(), cell.getYCoord(), cell.getAlive()));
      }
    }
  }
  
  public void restore_saved_state() {
    cells.clear();
    
    for (int row = 0; row < nbBlocksHeight; ++row) {
      for (int col = 0; col < nbBlocksWidth; ++col) {
        Cell cell = saved_cells.get(row * nbBlocksWidth + col);
        cells.add(new Cell(cell.getXCoord(), cell.getYCoord(), cell.getAlive()));
      }
    }
  }
  
  public boolean compute_alive(Cell c) {
    boolean newAlive = c.getAlive();
    int nbNeighboursAlive = 0;
    
    for (int row = c.getYCoord() - 1; row <= c.getYCoord() + 1; ++row) {
      for (int col = c.getXCoord() - 1; col <= c.getXCoord() + 1; ++col) {
        if (((0 <= row) && (row < nbBlocksHeight))
         && ((0 <= col) && (col < nbBlocksWidth))) {
          Cell neighCell = cells.get(row * nbBlocksWidth + col);
          if (neighCell.alive) nbNeighboursAlive += 1;
        }
      }
    }
    
    if (c.getAlive()) nbNeighboursAlive -= 1;
    
    if (c.getAlive()) {
      if ((nbNeighboursAlive < 2) || (nbNeighboursAlive > 3)) newAlive = false;
      else newAlive = true;
    } else {
      if (nbNeighboursAlive == 3) newAlive = true;
      else newAlive = false;
    }
    
    return newAlive;
  }
  
  public int getPopulation() {
    int populationCount = 0;
    
    for (int row = 0; row < nbBlocksHeight; ++row) {
      for (int col = 0; col < nbBlocksWidth; ++col) {
        if (cells.get(row * nbBlocksWidth + col).getAlive()) populationCount += 1;
      }
    }
    
    return populationCount;
  }
  
}