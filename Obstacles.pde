class Obstacles{
  // position of boulder 
  float x, y;
  // speeds
  float vx, vy;
  // array of all frames in the spritesheet 
  PImage[] frames;
  // sprite dimensions
  int spriteWidth, radius;
  // frames variables 
  int totalFrames, currentFrame, counter;
  // the current sprite which we are on 
  PImage currentSprite;
  boolean level2;
  // constructor 
  Obstacles(PImage spriteSheet, int amount, int imgWidth, int imgHeight, float tpx, float tpy, boolean lvl2){
    level2 = lvl2;
    if(level2){
      vy = 4.5;
      vx = 4.5;
    }
    else{
      vx = 4.5;
      vy = 4.5;
    }
    x = tpx-90;
    y = tpy;
    totalFrames = amount;
    spriteWidth = imgWidth/totalFrames;
    radius = spriteWidth/2;
    currentSprite = spriteSheet;
    frames = new PImage[totalFrames];
    // cutting the sprite sheet into smaller sprite blocks 
   for(int i = 0; i<totalFrames; i++){
     frames[i] = spriteSheet.get(i*(imgWidth/totalFrames), 0, imgWidth/totalFrames, imgHeight);
   }
 }
 
void resetPosition() {
    x = topX-90;
    y = topY;
  }
  
void update() {
  // gradient of the line 
  float m = (topY-bottomY)/(topX-bottomX);
    x -= vx;
    y = (m*x+bottomY);
    y += vy;
    
    // Check if boulder is off-screen or at bottom of mountain
    if(level2){
      if (x < -spriteWidth-100 || y > height+100) {
        resetPosition();
      }
    }
    else{
      if (x < -spriteWidth-200 || y > height+300) {
        resetPosition();
      }
    }
    
    updateFrames();
}
 
 void updateFrames(){
   counter++;
    // counter for speed 
   if(counter >=50){
     // use modulus division so that the frame wraps back to the first one after reaching max frames 
       currentFrame = (currentFrame + 1) % frames.length;
       counter = 0;
   }
 }
 
 void display(){
   // draw the current frame of the sprite 
   image(frames[currentFrame], x-radius, y-radius);
 }
 
 float getX(){
  return x; 
 }
 float getY(){
  return y; 
 }
 int getRadius(){
   return radius;
 }
}
