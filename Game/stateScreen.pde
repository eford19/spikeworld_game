//the square that will pop up at the beginning of the game (start screen) 
void startScreen() {
  textSize(25);
  fill(245, 218, 223);
  rect(100, 110, 850, 600);
  image(title, 160, 245);
  fill(120);
  strokeWeight(3);
  line(840, 350, 880, 380);
  line(840, 410, 880, 380);
  image(idleAnim[0], 400, 520); 
  image(friend2, 485, 545); 
}

//screen with all the instructions written on it - will appear at beginning of game 
void instructionScreen() {
  textSize(25);
  fill(245, 218, 223);
  
  rect(100, 110, 850, 600);
  fill(120);
  text("GO TO LEVEL 2", 130, 690);
  rect(buttonX, buttonY, buttonWidth, buttonHeight, 28);

  text("- USE ARROWS TO MOVE (← ↑ → ↓)", buttonX, 210);
  text("- DON'T GET HIT BY ANY SPIKES", buttonX, 250);
  text("- YOU MUST COLLECT ALL POTIONS, THEY WILL \n   ACTIVATE A MAGIC BUBBLE", buttonX, 290);
  text("- FOR LEVEL 2, PRESS THE 'C' KEY TO OPEN DOORS", buttonX, 370);
  fill(220, 20, 60);
  text("- AIM: KEEP ON JUMPING HIGHER TO SAVE YOUR \n   KIDNAPPED FRIEND WHO HAS A FEAR OF HEIGHTS", buttonX, 410);
  fill(255);
  textSize(35);
  text("START", 490, 540);
  noFill();
  rect(100, 645, 220, 70);
  image(idleAnim[0], 610, 600); 
  image(friend2, 695, 625); 
}

//screen that appears when player wins the game 
void finishScreen() {
  fill(245, 218, 223);
  rect(100, 250, 850, 430);
  fill(120);

  textSize(50);
  text("MISSION COMPLETE!!", buttonX, 365);
  textSize(28);
  text("Your friend is rescued!", buttonX, 415);
  if (level == levelNum.One) {text("From now, press 'C' to open doors", buttonX, 445);}

  rect(buttonX, buttonY, buttonWidth, buttonHeight, 28);
  fill(255);
  textSize(35);
  if (level == levelNum.One) {
    text("NEXT LEVEL", 440, 540);
  } else {
    text("FINISH", 440, 540);
  }
}

//screen that appears when the player dies 
void deadScreen() {
  textSize(50);
  fill(245, 218, 223);

  rect(100, 230, 850, 450);
  fill(120);
  text("SORRY BRO ~ YOU DIED!!!", 250, 400);

  rect(buttonX, buttonY, buttonWidth, buttonHeight, 28);
  fill(255);
  textSize(35);
  text("RESTART", 455, 540);
}

//screen for delivering the player a message 
void noticeScreen(String msg) {
  textSize(40);
  fill(245, 218, 223);

  rect(100, 230, 850, 450);
  fill(120);
  text(msg, 250, 400);
  image(potion, 500, 415);

  rect(buttonX, buttonY, buttonWidth, buttonHeight, 28);
  fill(255);
  textSize(35);
  text("OK", 500, 540);
}
