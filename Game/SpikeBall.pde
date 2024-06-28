class SpikeBall {
  float centerX, centerY;
  float radius=30;   

  //constructor:
  SpikeBall (float centerX, float centerY) {
    this.centerX = centerX;
    this.centerY = centerY;
  }

  //draws the spike ball on screen
  void drawSpikeBall() {   
    float screenY=world2ScreenY(sin(radians(rot+60))*80+centerY);
    image(spikeBall, cos(radians(rot+60))*80+centerX, screenY);      //draw spikeball 
    stroke(10);
    strokeWeight(3);
    line(centerX+radius, world2ScreenY(centerY)+radius, cos(radians(rot+60))*80+centerX+radius, screenY+radius);   //draw the rope part 
  }

  //checks if player has collided with spike ball. 
  void checkSpikeBallCollision() {
    float sbRectWidth = radius*2-10; 
    float sbRectHeight = radius*2-5;
    float sbRectX = cos(radians(rot+60))*80+centerX+5;
    float sbRectY = world2ScreenY(sin(radians(rot+60))*80+centerY)+2.5;
    
    if (checkXCollision(sbRectX, sbRectY, sbRectWidth, sbRectHeight) || checkYCollision(sbRectX, sbRectY, sbRectWidth, sbRectHeight)) {
      state=gameState.Died;   //player has died since collision has occurred. 
      delay(300);
    }
  }
}
