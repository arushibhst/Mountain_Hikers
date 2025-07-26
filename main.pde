enum states{
    idle, climb, jump, squish, dead
};
// MARSHMALLOWS
// initial state
states state = states.idle;
// background sprites
PImage b1, b2, b3;
int backgroundHeight = 1000;
int playerHeight = 64;
int boulderHt = 10;
// background x-coordinates and speed 
float by1 = 0, by2 = 0, by3 = 0, bx3 = 0, bv = 8;
float b1Z, b2Z, b3Z;
float mountainY;
float topX, topY, bottomX, bottomY;
int r;
Time time;
int t;
// player coordinates and speed 
float pX = bx3, pY = 500-playerHeight, vx, vy;
// obstacle info
float ox = topX-90, oy = topY; 
// MARSHMALLOW POSITIONS
float mx1, my1, mx2, my2, mx3, my3;
// MUD POSITIONS
float mudx1, mudx2, mudx3, mudy1, mudy2, mudy3;
// BOOLEANS
boolean down = false;
boolean movingUp = false;
boolean movingDown = false;
// VARIABLES TO START THE GAME
boolean start = false;
boolean quit = false;
boolean pause = false;
int pauseCounter = 0;
int titleCounter = 0;
int winCounter = 0;
int loseCounter = 0;
boolean lvl2 = false;
PImage c, i, j, o, s, d, m, mnu, muddy;
// CLASS OBJECTS
Background b;
Player climber, idler, jumper, squish, dead; 
Lives hearts;
Obstacles boulder;
Marshmallow m1, m2, m3;
Mud mud1, mud2, mud3;
Menu menu; 
// FONT
PFont f; 
// LIFE REMOVAL
int collisionCooldown = 0;
final int COOLDOWN_DURATION = 90;
int marshyCooldown = 0;
final int MARSHMALLOW_DURATION = 120;
void setup(){
  noSmooth();
  size(1000, 500);
  // INITIALISING SPEED
  vx = 14.5;
  vy = 5;
  if(lvl2){
    b3Z = 1.5;
  }
  else{
    b3Z = 1;
  }
  b2Z = 2;
  b1Z = 4;
  if(lvl2){
    time = new Time(60);
  }
  else{
    time = new Time(30);
  }
  // loading background images 
  b1 = loadImage("sky.png");
  b2 = loadImage("clouds.png");
  if(!lvl2){
    b3 = loadImage("mountain1.png");
  }
  // loading sprite images 
  c = loadImage("climbing.png");
  i = loadImage("idle.png");
  j = loadImage("jump.png");
  s = loadImage("squish.png");
  d = loadImage("dead.png");
  // obstacle
  o = loadImage("boulder.png");
  // marshmallow
  m = loadImage("marshmallow.png");
  // mud
  muddy = loadImage("mud.png");
  // MENU
  mnu = loadImage("menu.png");
  menu = new Menu(mnu);
  boulder = new Obstacles(o, 4, 240, 60, topX, topY, lvl2);
  // create background object 
  b = new Background(b1, b2, b3);
  // create player objects 
  climber = new Player(c, 6, 384, 64);
  idler = new Player(i, 4, 256, 64);
  jumper = new Player(j, 7, 448, 64);
  squish = new Player(s, 8, 512, 64);
  dead = new Player(d, 1, 64, 64);
  // LIVES
  hearts = new Lives(3);
  // DIMENSIONS OF MOUNTAIN
  bottomX = bx3;
  bottomY = by3 + 1000;
  topX = bx3 + 1000*8/9;
  topY = by3 + 1000*1/5;
  // RANDOM MARSHMALLOW X-POSITIONS
  mx1 = random(bottomX+10, topX-60);
  mx2 = random(bottomX+10, topX-60);
  if(lvl2){
    mx3 = random(bottomX+10, topX-60);
  }
  // RANDOM MUD X-POSITIONS
  if(lvl2){
    mudx1 = random(bottomX+10, topX-400);
  }
  // FONT
  //tring[] fontList = PFont.list();
  //printArray(fontList);
  f = createFont("Arial", 32);
  textFont(f);
  textAlign(CENTER,CENTER);
  frameRate(150);
}

void keyPressed(){
  if(key == ENTER || key == RETURN){
    start = true;
  }
  if(key == 'Q' || key == 'q'){
    quit = true;
  }
  if(key == 'P' || key == 'p'){
    pauseCounter++;
    pause = true;
    // resetting pause
    if(pauseCounter == 2){
      pauseCounter = 0;
      pause = false;
    }
  }
  // UP AND DOWN keypresses 
  if(key == CODED){
    if(keyCode == UP){
      int t = time.getTime();
      if(!lost() && !won() &&!pause){
        movingUp = true;
        down = false;
        state = states.climb;
        pY = pY - vy;
        pX = pX + vx;
        // moving background if player is at 20% the screen height
        if(pY > 0.1*height){
          by1 = by1+bv;
          by2 = by2+bv;
          by3 = by3+bv;
        }
      }
    }
    if(keyCode == DOWN){
      int t = time.getTime();
      if(!lost() && !won() && !pause){
        movingDown = true;
        down = true;
        state = states.climb;
        pY = pY + vy;
        pX = pX - vx;
      
      if(pY < 0.9*height){
          by1 = by1-bv;
          by2 = by2-bv;
          by3 = by3-bv;
       }
      }
   }
 }
if(key == ' '){
  int t = time.getTime();
    if(!lost() && !won() && !pause){
     state = states.jump;
        if(movingDown){
          pY = pY + vy;
          pX = pX - vx;
        }
        else if(movingUp){
          pY = pY - vy;
          pX = pX + vx;
      }
    }
  }
}
// key releases
void keyReleased(){
 if(key == CODED){
    if(keyCode == UP){
      state = states.idle; 
      movingUp = false;
    }
    if(keyCode == DOWN){
      state = states.idle;
      movingDown = false;
    }
  }
}

boolean onMountain(){
  int threshold = 50;
  float bx = b.getBx();
  float by = b.getBy();
  bottomX = b.getBx();
  bottomY = b.getBy();
  topX = b.getTx();
  topY = b.getTy();
  // gradient of the line 
  float m = (topY-by)/(topX-bx);
  // the equation of the line based on the players position 
  // the y-position of the line is the px*gradient + y-intercept of mountain 
  float y = m*pX+by;
  mountainY = y;
  if(pX >= topX){
    pX = topX;
  }
  if(pX <= bx+threshold && pY >= by-threshold){
    pX = bx+threshold;
    pY = by-threshold;
  }
  if(pY >= y){
    return true;
  }
  return false;
}

boolean collided(){
  if((pX >= ox-r && pX<= ox+r) && (pY+playerHeight/2 >= oy-r && pY+playerHeight/2<=oy+r)){
    return true;
  }
  return false;
}

boolean collidedMarshmallow(){
  if((pX+playerHeight/2 >= mx1-40 && pX+playerHeight/2<= mx1+40) || (pY+playerHeight/2 >= my1-40 && pY+playerHeight/2<=my1+40)){
    mx1 = bottomX - 600;
    my1 = topY - 600;
    return true;
  }
  if((pX+playerHeight/2 >= mx2-40 && pX+playerHeight/2<= mx2+40) || (pY+playerHeight/2 >= my2-40 && pY+playerHeight/2<=my2+40)){
      mx2 = bottomX - 600;
      my2 = topY - 600;
      return true;
    }
  if(!lvl2){
    if((pX+playerHeight/2 >= mx3-40 && pX+playerHeight/2<= mx3+40) || (pY+playerHeight/2 >= my3-40 && pY+playerHeight/2<=my3+40)){
      mx3 = bottomX - 600;
      my3 = topY - 600;
      return true;
    }
  }
    return false;
}

boolean collidedMud(){
  if((pX > mudx1 && pX< mudx1+200) && (pY+playerHeight >= mudy1 && pY+playerHeight<=mudy1+200)){
    return true;
  }
    return false;
}

boolean won(){
  int threshold = 35;
  if((pX >= topX-threshold && pX <= topX+threshold) && (pY >= topY-threshold && pY <= topY + threshold)){
    return true;
  }
  return false;
}

boolean lost(){
  if(t == 0 || hearts.getLives() == 0){
    return true;
  }
  return false;
}

void marshmallowPosition(){
  // gradient of the line 
  float m = (topY-bottomY)/(topX-bottomX);
  // the equation of the line based on the players position 
  // the y-position of the line is the px*gradient + y-intercept of mountain 
  my1 = (m*mx1+bottomY);
  my2 = (m*mx2+bottomY);
  if(lvl2){
    my3 = (m*mx3+bottomY);
  }
}

void mudPosition(){
  // gradient of the line 
  float m = (topY-bottomY)/(topX-bottomX);
  // the equation of the line based on the players position 
  // the y-position of the line is the px*gradient + y-intercept of mountain 
  mudy1 = (m*mudx1+bottomY)-198;
}

void resetGame() {
  // background x-coordinates and speed 
  by1 = 0;
  by2 = 0;
  by3 = 0;
  bx3 = 0;
  bv = 8;
  b1Z = 4;
  b2Z = 2;
  b3Z = 1;
  // obstacle info
  ox = topX-90; 
  oy = topY; 
  down = false;
  movingUp = false;
  movingDown = false;
  start = false;
  quit = false;
  pause = false;
  pauseCounter = 0;
  lvl2 = false;
  pX = bx3;
  pY = 500-playerHeight;
  hearts = new Lives(3);
  time = new Time(30);
  state = states.idle;
  // Reset other necessary variables
  setup(); // Call setup to reinitialize game objects
}

void changeLevel() {
  b3 = loadImage("mountain2.png");
  // background x-coordinates and speed 
  by1 = 0;
  by2 = 0;
  by3 = 0;
  bx3 = 0;
  bv = 8;
  b1Z = 4;
  b2Z = 2;
  b3Z = 1;
  // obstacle info
  ox = topX-90; 
  oy = topY; 
  down = false;
  movingUp = false;
  movingDown = false;
  start = true;
  quit = false;
  pause = false;
  pauseCounter = 0;
  lvl2 = true;
  pX = bx3;
  pY = 500-playerHeight;
  hearts = new Lives(3);
  time = new Time(60);
  state = states.idle;
  // Reset other necessary variables
  setup(); // Call setup to reinitialize game objects
}

void draw(){
  // PRESS ENTER TO START
  background(255);
  if(!start || quit){
    menu.displayMenu();
    // resetting start
    if(quit){
      resetGame();
    }
  }
  else{
    // TIME
    if(lvl2){
      mudPosition();
      // marshmallows
      mud1 = new Mud(muddy);
    }
    t = time.getTime();
    float Y1 = (by1/b1Z)%backgroundHeight;
    float Y2 = (by2/b2Z)%backgroundHeight;
    float Y3 = by3/b3Z;
    b.displayBackground(Y1, Y2, Y3, bx3, lvl2);
    if(lvl2){
      // MUD DISPLAYING
     mud1.display(mudx1, mudy1);
      if(collidedMud()){
        vx = 4.5;
        vy = 13.0;
      }
      else{
        vx = 10;
        vy = 29;
      }
    }
    if(!onMountain()){
      pY = mountainY-playerHeight;
    }
    if(state == states.climb){
      // if the state is idle, update idle player and display
      climber.updateFrames();
      climber.displayCharacter(pX, pY, true, false);
    }
    if(state == states.idle){
      // if the state is idle, update idle player and display
      idler.updateFrames();
      idler.displayCharacter(pX, pY, false, false);
    }
    if(state == states.dead){
      // if the state is idle, update idle player and display
      dead.updateFrames();
      dead.displayCharacter(pX, pY, false, true);
    }
    if(state == states.jump){
      // if the state is jump, update idle player and display
      int newV = 75;
      pY = pY - newV;
      jumper.updateFrames();
      jumper.displayCharacter(pX, pY, false, false);
      // if we have gone through all the jump frames, then make the player idle 
      if(jumper.returnJump()){
        state = states.idle;
        jumper.setJumpFalse();
      }
    }
    if(state == states.squish){
      // if the state is idle, update idle player and display
      if(!lost() && !won() && !pause){
        squish.updateFrames();
      }
      squish.displayCharacter(pX, pY, false, false);
      if(squish.returnSquish()){
        state = states.idle;
        squish.setSquishFalse();
      }
    }
    if(!lost() && !won() && !pause){
      time.updateTime();
    }
    time.displayTime();
     hearts.display();
     
    if(!lost() && !won() && !pause){
      boulder.updateFrames();
      boulder.update();
      boulder.display();
    }
     // need this to keep updating position
     ox = boulder.getX();
     oy = boulder.getY();
     r = boulder.getRadius();
     // only goes to this once cool down is 0
     if(collided() && collisionCooldown == 0){
        hearts.removeLife();
        state = states.squish;
        // resets cooldown for next time
        collisionCooldown = COOLDOWN_DURATION;
      }
      // skips to this ans keeps reducing cooldown
      if(collisionCooldown > 0){
        collisionCooldown--;
      }
      // MARSHMALLOW COLLISION
      if(collidedMarshmallow() && marshyCooldown == 0){
        hearts.addLife();
        // resets cooldown for next time
        marshyCooldown = MARSHMALLOW_DURATION;
      }
      // skips to this ans keeps reducing cooldown
      if(marshyCooldown > 0){
        marshyCooldown--;
      }
      if(hearts.getLives() == 0){
        state = states.dead;
      }
      if(lost()){
        loseCounter++;
        text("GAME OVER", width/2, height/2);
        if(loseCounter > 100){
          resetGame();
        }
     }
     else if(won()){
       winCounter++;
       text("YOU WON", width/2, height/2);
        if(winCounter > 100){
          changeLevel();
        }
     }
  }
  marshmallowPosition();
  // marshmallows
  m1 = new Marshmallow(m, 2, 72, 40, mx1, my1);
  m2 = new Marshmallow(m, 2, 72, 40, mx2, my2);
  if(lvl2){
    m3 = new Marshmallow(m, 2, 72, 40, mx3, my3);
  }
  if(start || !quit){
   m1.updateFrames();
   m1.display();
   m2.updateFrames();
   m2.display();
   if(lvl2){
     m3.updateFrames();
     m3.display();
   }
  }
  if(lvl2){
    titleCounter++;
    if(titleCounter < 200){
      text("LEVEL 2", width/2, height/2);
    }
  }
}
