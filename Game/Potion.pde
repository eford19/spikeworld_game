class Potion {
  float x, y;   //co-ords for location of potion 

  //constructor:
  Potion (float x, float y) {
    this.x = x;
    this.y = y;
  }

  //draws the potion on screen
  void drawPotion() {
    image(potion, x, world2ScreenY(y));
  }
  
  //if player is fully on the potion, increment num of collected potions, and remove from arraylist of potions. 
  void detectCollection() {
    float potionX = x+10; 
    float potionY = world2ScreenY(y)+12; 
    float potionWidth = potion.width/2; 
    float potionHeight = potion.height/2; 
    float playerRectX = (playerX-currentAnimation[animNum].width/2+22);
    float playerRectY = world2ScreenY(playerY)+30;
    
     if (potionX+potionWidth/2 > playerRectX && potionX+potionWidth/2<playerRectX+playerRectWidth
         && potionY+potionHeight/2 > playerRectY && potionY+potionHeight/2<playerRectY+playerRectHeight) {
           if (collectedPotionNum<2 && level == levelNum.Two) {drawnDoors.add(allDoors.get(collectedPotionNum));}   //if first 2 potions of L2, make doors appear on screen
           collectedPotionNum++; 
           allPotions.remove(this);
     }
  }
}
