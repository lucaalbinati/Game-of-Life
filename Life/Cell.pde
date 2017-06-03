class Cell {
  private int xCoord;
  private int yCoord;
  private boolean alive;
  
  public Cell(int xCoord, int yCoord, boolean alive) {
    this.xCoord = xCoord;
    this.yCoord = yCoord;
    this.alive = alive;
  }
  
  public int getXCoord() {
    return xCoord;
  }
  
  public int getYCoord() {
    return yCoord;
  }
  
  public boolean getAlive() {
    return alive;
  }
  
  public void setXCoord(int newXCoord) {
    xCoord = newXCoord;
  }
  
  public void setYCoord(int newYCoord) {
    yCoord = newYCoord;
  }
  
  public void setAlive(boolean newAlive) {
    alive = newAlive;
  }
  
}