class Player{
  boolean fullJump = false; 
  boolean fullSquish = false;
  // position of player 
  float x, y;
  // array of all frames in the spritesheet 
  PImage[] frames;
  // sprite dimensions
  int spriteWidth, halfWidth;
  // frames variables 
  int totalFrames, currentFrame, counter;
  // the current sprite which we are on 
  PImage currentSprite;
  // constructor 
  Player(PImage spriteSheet, int amount, int imgWidth, int imgHeight){
    totalFrames = amount;
    spriteWidth = imgWidth/totalFrames;
    halfWidth = spriteWidth/2;
    currentSprite = spriteSheet;
    frames = new PImage[totalFrames];
    // cutting the sprite sheet into smaller sprite blocks 
   for(int i = 0; i<totalFrames; i++){
     frames[i] = spriteSheet.get(i*(imgWidth/totalFrames), 0, imgWidth/totalFrames, imgHeight);
   }
 }
 void updateFrames(){
   counter++;
   // for jumping, if we have reached the max amount of frames, then set boolean variable to true and return to frame 0
   if(currentFrame >= frames.length - 1){
         fullJump = true;
         fullSquish = true;
         currentFrame = 0;
    }
     // counter for speed 
   if(counter >=15){
     // use modulus division so that the frame wraps back to the first one after reaching max frames 
       currentFrame = (currentFrame + 1) % frames.length;
       counter = 0;
   }
 }
 
 void displayCharacter(float x1, float y1, boolean climb, boolean dead){
   x = x1;
   y = y1;
   if(dead){
     pushMatrix();
     translate(x, y);
       // ROTATE
      rotate(-PI/4.0); 
      // draw the current frame of the sprite 
      image(frames[currentFrame], -halfWidth, halfWidth-20);
     popMatrix();
   }
   else if(climb){
     pushMatrix();
     translate(x+halfWidth, y+halfWidth/2);
       // ROTATE
      rotate(PI/6.0); 
      // draw the current frame of the sprite 
      translate(0, 0);
      // FIX MARSHMALLOWS COLLISION
      image(frames[currentFrame], -halfWidth, -halfWidth);
     popMatrix();
   }
   else{
     // draw the current frame of the sprite 
     image(frames[currentFrame], x-halfWidth, y);
   }
 }
 boolean returnJump(){
   return fullJump;
 }

void setJumpFalse(){
   fullJump = false;
 } 
 
boolean returnSquish(){
   return fullSquish;
 }

void setSquishFalse(){
   fullSquish = false;
 }
 
}
