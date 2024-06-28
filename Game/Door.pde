class Door {
  float x1, y1;                       //x,y co-ords for the location of the first door (the one player should enter) 
  float x2, y2;                       //x,y co-ords for the location of the second door (the one player should exit)
  float prevPlayerX, prevPlayerY;     //x,y co-ords for the player's new position at the second door  
  float newPlayerX, newPlayerY;       //x,y co-ords for the player's new position at the first door 

  //constructor:
  Door (float x1, float y1, float x2, float y2, float prevPlayerX, float prevPlayerY, float newPlayerX, float newPlayerY) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.prevPlayerX = prevPlayerX;
    this.prevPlayerY = prevPlayerY;
    this.newPlayerX = newPlayerX;
    this.newPlayerY = newPlayerY;
  }

  //draws the two doors (1 for entering and the corresponding one for exiting) 
  void drawDoor() {
    image(door, x1, world2ScreenY(y1));
    image(door, x2, world2ScreenY(y2));
  }

  //teleports the player - just changes their x and y position 
  //doornum is the position of this door in the arraylist - its for determining whether it's a door supposed to be for exiting or entering
  //(even doorNum is entering door and odd doorNum is exiting door) 
  void teleportPlayer(int doorNum) {
    if (doorNum%2==0) {
      playerX = newPlayerX;
      playerY = newPlayerY;
    }
    else {
      playerX = prevPlayerX;
      playerY = prevPlayerY;
    }
  }
}
