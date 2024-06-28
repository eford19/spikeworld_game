class Spikes {
  float x, y;
  float spikesNum;           //number of times spikes should be drawn (total num of spikes is spikesNum*2 since 2 are in the image) 
  float spikesWidth=30;
  float spikesHeight=40;

  //constructor:
  Spikes (float x, float y, float spikesNum) {
    this.x = x;
    this.y = y;
    this.spikesNum = spikesNum;
  }

  //draws the spikes on screen
  void drawSpikes() {
    for (int i=0; i<spikesNum; i++) {
      image(spikes, x+i*spikesWidth, world2ScreenY(y));
    }
  }

  //checks if player has collided with spikes.
  void checkSpikeCollision() {
    float spikesRectWidth = spikesWidth*spikesNum;  
    float spikesRectHeight = spikesHeight-10;
    float spikesRectX = x-1;
    float spikesRectY = world2ScreenY(y)+20;

    //calls the 2 methods to check if collision in x-direction and y-direction. If collided, player is dead
    if (checkXCollision(spikesRectX, spikesRectY, spikesRectWidth, spikesRectHeight) ||
      checkYCollision(spikesRectX, spikesRectY, spikesRectWidth, spikesRectHeight)) {
      state=gameState.Died;
      delay(300);   //delay so that the dead screen doesn't appear so quickly 
    }
  }
}
