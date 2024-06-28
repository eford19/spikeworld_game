enum gameState {
  Start, Instruction, Playing, Died, Stop, Finished 
};
gameState state;   //for what state of the game we are in 

enum levelNum {
  One, Two 
};
levelNum level;  //for what level we are at. 

//background images 
PImage backgroundL1;
PImage backgroundL2;
PImage currentbackground;   //variable for which background should be displayed now.

//for the player sprite 
PImage playerIdle;
PImage playerRun;
PImage[] idleAnim = new PImage[2];
PImage[] runAnim = new PImage[4];
PImage[] jumpAnim = new PImage[1];
PImage[] currentAnimation;
int animNum;
//for the friend sprite 
PImage friend;
PImage friend2;

//some game objects 
PImage platform;
PImage potion; 
PImage bubble; 
PImage door; 

//for spikes 
PImage spikes;
PImage spikesLarge;
PImage spikesVert;
PImage spikeBall;
int rot=0; 

//images containing text 
PImage help;
PImage title;

//dimensions for loading PImages
int playerWidth = 32;
int playerHeight = 32;   
int playerDimen = 80;

//dimensions for player rectangle 
float playerRectWidth = 38; 
float playerRectHeight = 50;

//player position & velocities 
float playerX;
float playerY;
float playerVelX = 0;
float playerVelY = 0;
float movingV = 5;
float cameraY;       //and also for camera Y position too 

//keeping track of player's direction & motion type 
boolean running;
boolean idling;
boolean jumping;
String directionX;
String directionY;

int jumpIndex;  //number to control player's jumping 

//for player interaction with platform
boolean on;
Platform currentPlatform;

//things to make player interaction with objects work properly 
float diffY;
int collectedPotionNum; 
float bubbleY;
boolean insideBubble; 
boolean bubbleWarning; 

//arraylists to store objects 
ArrayList<Platform> allPlatforms;
ArrayList<Spikes> allSpikes;
ArrayList<SpikeBall> allSpikeBalls;
ArrayList<Potion> allPotions;
ArrayList<Door> allDoors;
ArrayList<Door> drawnDoors;

//button dimensions 
int buttonX = 230;
int buttonY = 480;
int buttonWidth = 600; 
int buttonHeight = 90; 
