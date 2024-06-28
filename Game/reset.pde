//for resetting the level - these things are done no matter what level it is 
void setupAllLevels() {
  animNum=0;

  rot=0;
  collectedPotionNum=0;
  insideBubble=false;
  bubbleWarning=false;

  currentAnimation = idleAnim;
  jumpIndex=-1;

  playerX = 265;
  playerY = 1400;
  playerVelX = 0;
  playerVelY = 0;

  running = false;
  idling = true;
  jumping = false;
  directionX = "right";
  directionY = "";

  cameraY = backgroundL1.height-1000;

  allPlatforms = new ArrayList<Platform>();
  allSpikes = new ArrayList<Spikes>();
  allSpikeBalls = new ArrayList<SpikeBall>();
  allPotions = new ArrayList<Potion>();
}

//for resetting what only happens in level 1 
void setupLevel1() {
  level = levelNum.One;
  currentbackground = backgroundL1;     
  bubbleY=425;
  
  loadObjectsL1();   //call to load objects 
  //platform that player starts on: 
  Platform startP = new Platform(200, 1450, 2);
  allPlatforms.add(startP);
  currentPlatform = startP;
}

//for resetting what only happens in level 2
void setupLevel2() {
  level = levelNum.Two;
  currentbackground = backgroundL2;
  bubbleY=525;
  
  allDoors = new ArrayList<Door>();
  drawnDoors = new ArrayList<Door>();
  
  loadObjectsL2();    //call to load objects 
  //platform that player starts on: 
  Platform startP = new Platform(200, 1520, 2);
  allPlatforms.add(startP);
  currentPlatform = startP;
}

//loading objects in L1 - reads from file to create object and put into arraylist. 
void loadObjectsL1() {
  String[] lines;
  try {
    lines = loadStrings("levels/level1Objects.txt");
    for (int i=1; i<21; i++) {
      int[] objInfo = int(split(lines[i], '\t'));
      allPlatforms.add(new Platform(objInfo[0], objInfo[1], objInfo[2]));    
    }
    for (int i=22; i<25; i++) {
      int[] objInfo = int(split(lines[i], '\t'));
      allSpikes.add(new Spikes(objInfo[0], objInfo[1], objInfo[2]));
    }
    for (int i=26; i<29; i++) {
      int[] objInfo = int(split(lines[i], '\t'));
      allSpikeBalls.add(new SpikeBall(objInfo[0], objInfo[1]));
    }
    for (int i=30; i<35; i++) {
      int[] objInfo = int(split(lines[i], '\t'));
      allPotions.add(new Potion(objInfo[0], objInfo[1]));
    }
  }
  catch (Exception e) {
    println(e);
    return;
  }
}

//loading objects in L2 - reads from file to create object and put into arraylist. 
void loadObjectsL2() {
  String[] lines;
  try {
    lines = loadStrings("levels/level2Objects.txt");
    for (int i=1; i<26; i++) {
      int[] objInfo = int(split(lines[i], '\t'));
      allPlatforms.add(new Platform(objInfo[0], objInfo[1], objInfo[2]));
    }
    for (int i=27; i<29; i++) {
      int[] objInfo = int(split(lines[i], '\t'));
      allSpikes.add(new Spikes(objInfo[0], objInfo[1], objInfo[2]));
    }
    for (int i=30; i<33; i++) {
      int[] objInfo = int(split(lines[i], '\t'));
      allSpikeBalls.add(new SpikeBall(objInfo[0], objInfo[1]));
    }
    for (int i=34; i<39; i++) {
      int[] objInfo = int(split(lines[i], '\t'));
      allPotions.add(new Potion(objInfo[0], objInfo[1]));
    }
    for (int i=40; i<42; i++) {
      int[] objInfo = int(split(lines[i], '\t'));
      allDoors.add(new Door(objInfo[0], objInfo[1], objInfo[2], objInfo[3], objInfo[4], objInfo[5], objInfo[6], objInfo[7]));
    }
  }
  catch (Exception e) {
    println(e);
    return;
  }
}
