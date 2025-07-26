class Lives{
  int startingPoint = 80;
  int size = 32;
  int spriteWidth = 64;
  int lives;
  PImage heart = loadImage("heart.png");
  Lives(int amount){
    lives = amount;
  }
  
  int getLives(){
    return lives;
  }
 
 void addLife(){
   lives++;
 }
 
 void removeLife(){
   if(lives>0){
     lives--;
   }
 }

void display(){
    for(int h=0; h<lives; h++){
     // draw the current frame of the sprite 
     image(heart, startingPoint+(size*h), 10);
    }
}  

}
