//checks if collision has occurred with player & bubble 
void bubbleCollision() {
  float bubbleX = 405;
  float bubbleY2 = world2ScreenY(bubbleY)+20;
  float bubbleWidth = bubble.width-85;
  float bubbleHeight = bubble.height-45;      
  float playerRectX = (playerX-currentAnimation[animNum].width/2+22);    
  float playerRectY = world2ScreenY(playerY)+30;

  //checking if center of bubble is in between the edges of the player 
  if (bubbleX+bubbleWidth/2 > playerRectX && bubbleX+bubbleWidth/2<playerRectX+playerRectWidth
    && bubbleY2+bubbleHeight/2 > playerRectY && bubbleY2+bubbleHeight/2<playerRectY+playerRectHeight) {
    //if all 5 potions hasn't been collected - show a notification (bubbleWarning) 
    if (collectedPotionNum!=5 && !bubbleWarning) {
      state = gameState.Stop;
      bubbleWarning=true;
    //otherwise begin making bubble rise up 
    } else if (collectedPotionNum==5) {
      insideBubble=true;
    }
  }
}

//make the bubble rise up - stops when the bottom of bubble is just on the top of the platform. 
void bubbleTravel() {
  if (bubbleY>205) {   
    cameraY-=2;
    bubbleY -= 2;
    playerY -= 2;
    playerVelX = 0;
    stopMoving();
  } else {
    insideBubble=false;
  }
}

//check if the player has completed the level. If so gameState=finished now 
void detectFinish() {
  float nearFriendWidth = 60;
  float nearFriendHeight = 50;
  float nearFriendX = 290;
  float nearFriendY = world2ScreenY(280);

  if (checkXCollision(nearFriendX, nearFriendY, nearFriendWidth, nearFriendHeight)) {
    state=gameState.Finished;
  }
}
