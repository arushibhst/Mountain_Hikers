class Mud{
  int size = 200;
  int patches;
  float x, y;
  PImage m;
  Mud(PImage mud){
    m = mud;
  }
  
  float getX(){
    return x;
  }
  
  float getY(){
    return y;
  }
 
void display(float X, float Y){
  x = X;
  y = Y;
  image(m, x, y);
}  

}
