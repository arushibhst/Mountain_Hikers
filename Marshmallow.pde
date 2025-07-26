class Marshmallow{
  // position of marshmallow
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
  Marshmallow(PImage spriteSheet, int amount, int imgWidth, int imgHeight, float X, float Y){
    x = X;
    y = Y;
    totalFrames = amount;
    spriteWidth = imgWidth/totalFrames;
    halfWidth = spriteWidth/2;
    currentSprite = spriteSheet;
    frames = new PImage[totalFrames];
    // cutting the sprite sheet into smaller sprite blocks 
   for(int i = 0; i<totalFrames; i++){
     frames[i] = spriteSheet.get(i*(spriteWidth), 0, spriteWidth, imgHeight);
   }
 }
 
 void updateFrames(){
   counter++;
    // counter for speed 
   if(counter >=10){
     // use modulus division so that the frame wraps back to the first one after reaching max frames 
       currentFrame = (currentFrame + 1) % frames.length;
       counter = 0;
   }
 }
 
 void display(){
   // draw the current frame of the sprite 
   image(frames[currentFrame], x-spriteWidth, y-spriteWidth);
 }
 
 float getX(){
  return x; 
 }
 float getY(){
  return y; 
 }
 int getWidth(){
   return spriteWidth;
 }
}
