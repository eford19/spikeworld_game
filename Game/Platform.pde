class Platform {
  float x, y;
  float platformWidth = 70;
  float platformHeight = 30;
  float platformNum;             //the number of bricks this platform consists of
  float platformRectWidth;

  //constructor:
  Platform (float x, float y, float platformNum) {
    this.x = x;
    this.y = y;
    this.platformNum = platformNum;
    this.platformRectWidth = platformWidth*platformNum;
  }

  //draws the platform on screen
  void drawPlatform() {
    for (int i=0; i<platformNum; i++) {
      image(platform, x+i*platformWidth, world2ScreenY(y));
    }
  }

  //checks whether there is a collision and does stuff...
  void checkCollision() {
    boolean xCollision=false;
    boolean yCollision=false;

    //checks for collision if player keeps moving in current x direction
    if (checkXCollision(x, world2ScreenY(y), platformRectWidth, platformHeight)) {
      xCollision=true;
    }

    //checks for collision if player keeps moving in current y direction
    if (checkYCollision(x, world2ScreenY(y), platformRectWidth, platformHeight)) {
      yCollision=true;

      //if player has just landed on a platform they are now idle and current platform is set to this object.
      if (playerY+playerRectHeight<=y && playerY!= y-3-playerDimen && !insideBubble) {
        diffY = playerY - (y-3-playerDimen);
        playerY =y-3-playerDimen;
        stopMoving();
        currentPlatform = this;
      }
      //otherwise if it has collided it must be from the bottom so make it fall back down.
      else if (xCollision && yCollision) {
        moveDown();
      }
    }

    //if crashed into the sides of the platform, make it fly back in the opposite direction, falling downwards
    if (xCollision && !yCollision && !(playerX>x+2 && playerX<x+platformRectWidth-2)) {
      moveDown();
      playerVelX *= -0.5;
    }
  }

  //method only called by current platform - and checks if the player is still on it 
  void checkOn() {
    if ((playerY == y-3-playerDimen || playerY == y+2-playerDimen) && playerX+playerRectWidth/2>x-2 && playerX-playerRectWidth/2<x+platformRectWidth+2) {
      on=true;
    }
  }

  
  //only for level 2 - this method is only called for platforms with a door - so it checks if player is on this platform and
  //if it is, it calls method to teleport player.  
  boolean checkTeleport(int doorNum) {
    float playerRectX = (playerX-currentAnimation[animNum].width/2+22);
    if (playerY == y-3-playerDimen && playerRectX+playerRectWidth>x && playerRectX<x+platformRectWidth) {
      drawnDoors.get(int(doorNum/2)).teleportPlayer(doorNum);
      return true;
    }
    return false;
  }
}
