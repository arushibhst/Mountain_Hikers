class Menu{
  PImage m;
  float Y = 0;
  float X = 0; 
  Menu(PImage m1){
    m = m1;
  }
  void displayMenu(){
    image(m, X, Y);
  }
}
