class Background{
  // background sprites
  PImage b1, b2, b3;
  float b1Y = 0;
  float b2Y = 0;
  float b3Y = 0;
  float b3X; 
  float bottomX;
  float bottomY;
  float rightX;
  float rightY;
  float topX;
  float topY;
  int backgroundHeight = 1000;
  Background(PImage ba, PImage bb, PImage bc){
    b1 = ba;
    b2 = bb;
    b3 = bc; 
  }
  void displayBackground(float y1, float y2, float y3, float x3, boolean lvl){
    b1Y = y1;
    b2Y = y2;
    b3Y = y3-backgroundHeight/2;
    b3X = x3;
    if(!lvl){
      bottomX = b3X;
      bottomY = b3Y + 1000;
      rightX = b3X + 1000;
      rightY = b3Y + 1000;
      topX = b3X + 1000*8/9;
      topY = b3Y + 1000*1/5;
    }
    else{
      bottomX = b3X;
      bottomY = b3Y + 1000;
      rightX = b3X + 1000;
      rightY = b3Y + 1000;
      topX = b3X + 1000*7/8;
      topY = b3Y;
    }
    image(b1, 0, b1Y-backgroundHeight/2);
    image(b2, 0, b2Y-backgroundHeight/2);
    image(b3, b3X, b3Y);
  }
  
  // GETTERS 
  public float getBx(){
    return bottomX;
  }
  public float getBy(){
    return bottomY;
  }
  public float getTx(){
    return topX;
  }
  public float getTy(){
    return topY;
  }
  public float getrightx(){
    return rightX;
  }
  public float getrighty(){
    return rightY;
  }
}
