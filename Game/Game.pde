void setup() {
  size(1050, 950);

  //loading images and resizing
  backgroundL1 = loadImage("assets/backgroundL1-1.jpg");
  backgroundL1.resize(backgroundL1.width/2, backgroundL1.height/2);
  backgroundL2 = loadImage("assets/backgroundL2.jpg");
  backgroundL2.resize(backgroundL2.width, backgroundL2.height-200);

  playerIdle = loadImage("assets/player_idle.png");
  playerRun = loadImage("assets/player_run.png");
  friend = loadImage("assets/friend.png");
  friend.resize(75, 75);
  friend2 = loadImage("assets/friend_idle.png");
  friend2.resize(73, 55);

  platform = loadImage("assets/platform1.png");
  platform.resize(70, 30);

  spikes = loadImage("assets/spikes.png");
  spikes.resize(30, 40);
  spikesVert = loadImage("assets/spikesVert.png");
  spikesVert.resize(45, 60);
  spikeBall = loadImage("assets/SpikeBall.png");
  spikeBall.resize(60, 60);
  spikesLarge = spikes.copy();
  spikesLarge.resize(45, 60);

  potion = loadImage("assets/potion.png");
  potion.resize(50, 65);
  bubble = loadImage("assets/bubble.png");
  bubble.resize(190, 150);
  door = loadImage("assets/Door.png");
  door.resize(55, 65);

  title = loadImage("assets/title.png");
  title.resize(650, 270);
  help = loadImage("assets/help.png");
  help.resize(80, 80);

  //store animation in arrays
  for (int i=0; i<idleAnim.length; i++) {
    idleAnim[i] = playerIdle.get(i*playerWidth, 0, playerWidth, playerHeight);
    idleAnim[i].resize(playerDimen, playerDimen);
  }
  for (int i=0; i<runAnim.length; i++) {
    runAnim[i] = playerRun.get(i*playerWidth, 0, playerWidth, playerHeight);
    runAnim[i].resize(playerDimen, playerDimen);
  }
  jumpAnim[0] =  loadImage("assets/player_jump.png");
  jumpAnim[0].resize(playerDimen, playerDimen);

  //load rest of program
  setupAllLevels();
  setupLevel1();
  state = gameState.Start;
}

void draw() {
  image(currentbackground, 0, world2ScreenY(0));
  if (state == gameState.Start) {
    startScreen();
  } else if (state == gameState.Instruction) {
    instructionScreen();
  } else if (state == gameState.Playing) {
    on = false;   //not on any platform (yet)

    //collision checking for player
    for (Platform p : allPlatforms) {
      p.checkCollision();
      if (currentPlatform!=null && currentPlatform==p) {
        p.checkOn();    //check if player is on a platform
      }
    }
    for (Spikes s : allSpikes) {
      s.checkSpikeCollision();
    }
    for (SpikeBall sb : allSpikeBalls) {
      sb.checkSpikeBallCollision();
    }

    //fall down if not colliding with anything, and not jumping
    if (!on && !jumping && !insideBubble) {
      moveDown();
    }

    //call methods to make the bubble work
    if (insideBubble) {
      bubbleTravel();
    } else {
      bubbleCollision();
    }

    movePlayer();
    moveCamera();

    checkBoundary();
    detectFinish();

    //get player animation
    currentAnimation = setAnimation();
    if (jumping) {
      animNum=0;
      doJump();
    } else {
      animNum = (frameCount/6)%currentAnimation.length;
    }

    //now start drawing everything
    image(currentbackground, 0, world2ScreenY(0));

    if (level == levelNum.Two) {
      for (Door d : drawnDoors) {
        d.drawDoor();
      }
    }

    for (Platform p : allPlatforms) {
      p.drawPlatform();
    }
    for (Spikes s : allSpikes) {
      s.drawSpikes();
    }

    rot+=4;
    for (SpikeBall sb : allSpikeBalls) {
      sb.drawSpikeBall();
    }
    
    image(bubble, 365, world2ScreenY(bubbleY));
    image(friend, 250, world2ScreenY(255));
    image(help, 310, world2ScreenY(230));

    for (int i=0; i<allPotions.size(); i++) {
      Potion p = allPotions.get(i);
      p.drawPotion();
      p.detectCollection();    //collecting potion
    }

    //draw in top right corner number of potions collected 
    rect(890, 30, 100, 60);
    noFill();
    image(potion, 900, 30);
    textSize(35);
    text(collectedPotionNum, 950, 68);

    drawPlayer();
    drawEdgeSpikes();

    diffY=0;
  } else if (state == gameState.Died) {
    deadScreen();
  } else if (state == gameState.Stop) {
    noticeScreen("NOTE: You need to get all potions.");
  } else if (state == gameState.Finished ) {
    finishScreen();
  } 
}

//return the player animation - either idle, running, jumping
PImage[] setAnimation() {
  if (jumping) {
    return jumpAnim;
  } else if (running) {
    return runAnim;
  } else {
    return idleAnim;
  }
}

//draw the player on screen
void drawPlayer() {
  if (directionX.equals("right")) {
    image(currentAnimation[animNum], playerX-currentAnimation[animNum].width/2, world2ScreenY(playerY));
  } else {
    //if player is facing left, flip the animation
    pushMatrix();
    scale( -1, 1 );
    image(currentAnimation[animNum], -(playerX-(currentAnimation[animNum].width/2)+(currentAnimation[animNum].width)), world2ScreenY(playerY));
    popMatrix();
  }
}

//move the player by its velocity size
void movePlayer() {
  playerX += playerVelX;
  playerY -= playerVelY;
}

//move camera (vertically) based on player's Y-velocity
void moveCamera() {
  //return if inside bubble
  if (insideBubble) {
    return;
  }

  //start moving camera once player has moved up 700 pixels from bottom. (70%)
  float playerTop = playerY+playerRectHeight;
  if (playerTop <= backgroundL1.height-700) {
    if (jumping  && directionY.equals("up")) {
      cameraY -= movingV;
    } else if (jumping  && (directionY.equals("down") || directionY.equals("jumpDown"))) {
      cameraY +=movingV;
    }
    cameraY -=diffY;
  }
}

//convert world co-ords to screen co-ords
float world2ScreenY(float y) {
  return (y-cameraY);
}

//if 'C' is pressed - check and execute teleporting if required
void isCPressed() {
  for (int i=0; i<drawnDoors.size()*2; i++) {
    if (allPlatforms.get(i).checkTeleport(i)) {
      return;
    }
  }
}

void keyPressed() {
  if (keyCode == RIGHT) {
    moveRight();
  }
  if (keyCode == LEFT) {
    moveLeft();
  }
  if (keyCode == UP && !jumping) {
    moveUp();
  }
  if (keyCode == DOWN) {
    moveDown();
  }
  if ((key == 'C' || key == 'c') && level == levelNum.Two) {
    isCPressed();
  }
}

void keyReleased() {
  if (!directionY.equals("up")) {
    stopMoving();
  }
}

//sets up everything to make the player move right
void moveRight() {
  playerVelX = movingV;
  running = true;
  directionX = "right";
}

//sets up everything to make the player move left
void moveLeft() {
  playerVelX = -movingV;
  running = true;
  directionX = "left";
}

//sets up everything to make the player move up
void moveUp() {
  jumping = true;
  playerVelY = movingV;
  directionY = "up";
}

//sets up everything to make the player move down
void moveDown() {
  jumping = true;
  playerVelY = -movingV;
  directionY = "down";
}

//sets up everything to make the player stop moving (idle)
void stopMoving() {
  playerVelX = 0;
  playerVelY = 0;
  directionY = "";
  idling = true;
  running = false;
  jumping = false;
  jumpIndex=-1;
}

//makes the player jump
void doJump() {
  if (directionY.equals("up")||directionY.equals("jumpDown")) {
    jumpIndex++;
    //when reaching halfway flip the direction of velocity
    if (jumpIndex==20) {
      directionY="jumpDown";
      playerVelY *= -1;
    }
    //return to idle once reaching end of jump (jumpindex=40)
    if (jumpIndex==40) {
      stopMoving();
    }
  }
}

//check if the player has gone outside the camera view - die if it has
void checkBoundary() {
  float playerRectX = (playerX-currentAnimation[animNum].width/2+22);
  float playerRectY = world2ScreenY(playerY)+30;
  if (playerRectX < 20 || playerRectX + playerRectWidth > width-20 || playerRectY+playerRectHeight > height-20) {
    state=gameState.Died;
    delay(300);
  }
}

//draw the spikes on all sides of the screen except the top. 
void drawEdgeSpikes() {
  float spikesWidth=45; 
  float spikesHeight=60; 

  for (int i=0; i<width; i+=spikesWidth) {
    image(spikesLarge, i, height-60);
  }
  for (int i=0; i<height; i+=spikesHeight) {
    image(spikesVert, 0, i);
  }
  for (int i=0; i<height; i+=spikesHeight) {
    pushMatrix();
    scale( -1, 1 );
    image(spikesVert, -(width-spikesHeight+58), i);
    popMatrix();
  }
}

//checks if main button is clicked
boolean overButton() {
  if (mouseX >= buttonX && mouseX <= buttonX + buttonWidth &&
    mouseY >= buttonY && mouseY <= buttonY + buttonHeight) {
    return true;
  }
  return false;
}

//checks if all other buttons are clicked (ie. 'Go to Level 2' AND the one going to instructions page)
boolean overOtherButton() {
  //checking 'go to L2'
  if (mouseX >= 820 && mouseX <= 900 &&
    mouseY >= 335 && mouseY <= 425 && state == gameState.Start) {
    return true;
  }
  //checking 'go to instructions' 
  if (mouseX >= 100 && mouseX <= 320 &&
    mouseY >= 665 && mouseY <= 735 && state == gameState.Instruction) {
    nextLevel();
    return true;
  }
  return false;
}

//function just to start up the next level (which is level 2) 
void nextLevel() {
  setupAllLevels();
  if (level == levelNum.One) {
    setupLevel2();
    state = gameState.Playing;
  } 
}

//check if a button is clicked and act upon it (like change gameState) 
void mousePressed() {
  if (!overButton() && state != gameState.Start && state != gameState.Instruction) {
    return;
  }

  if (state == gameState.Start) {
    if (overOtherButton()) {
      state = gameState.Instruction;
    }
  } else if (state == gameState.Instruction) {
    if (overOtherButton()) {
      return;
    }
    if (overButton()) {
      state = gameState.Playing;
    }
  } else if (state == gameState.Died) {
    setupAllLevels();
    if (level == levelNum.One) {
      setupLevel1();
    } else {
      setupLevel2();
    }
    state = gameState.Playing;
  } else if (state == gameState.Stop) {
    state = gameState.Playing;
  } else if (state == gameState.Finished) {
    if (level == levelNum.One) {
      nextLevel();
    } else {
      exit();
    }
  }
}

//check if any collision has occurred in the x-direction 
boolean checkXCollision(float objectRectX, float objectRectY, float objectRectWidth, float objectRectHeight) {
  float playerRectX = (playerX-currentAnimation[animNum].width/2+22);
  float playerRectY = world2ScreenY(playerY)+30;
  if (playerRectX + playerRectWidth + playerVelX > objectRectX &&
    playerRectX + playerVelX < objectRectX + objectRectWidth &&
    playerRectY + playerRectHeight > objectRectY &&
    playerRectY < objectRectY + objectRectHeight) {
    return true;
  }
  return false;
}

//check if any collision has occurred in the y-direction 
boolean checkYCollision(float objectRectX, float objectRectY, float objectRectWidth, float objectRectHeight) {
  float playerRectX = (playerX-currentAnimation[animNum].width/2+22);
  float playerRectY = world2ScreenY(playerY)+30;
  if (playerRectX + playerRectWidth > objectRectX &&
    playerRectX < objectRectX + objectRectWidth &&
    playerRectY + playerRectHeight + playerVelY > objectRectY &&
    playerRectY + playerVelY< objectRectY + objectRectHeight) {
    return true;
  }
  return false;
}
