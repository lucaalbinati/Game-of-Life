class Button {
  
  private int xPos;
  private int yPos;
  private int buttonWidth;
  private int buttonHeight;
  
  public Button(int xPos, int yPos, int buttonWidth, int buttonHeight) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;
  }
  
  public void display() {
    fill(buttonColor);
    rect(xPos, yPos, buttonWidth, buttonHeight);
    fill(240, 240, 240);
    rect(xPos + 5, yPos + 5, buttonWidth - 10, buttonHeight - 10);
    noFill();
  }
  
  public boolean containsCoord(int coordX, int coordY) {
    return (xPos <= coordX && coordX <= (xPos + buttonWidth))
        && (yPos <= coordY && coordY <= (yPos + buttonHeight));
  }
  
}