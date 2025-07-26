class Time{
  int time;
  int counter = 0;
  Time(int t){
    time = t;
  }
  void updateTime(){
    counter++;
    if(counter == 61){
      if(time>0){
        time--;
      }
      counter = 0;
    }
  }
  void resetTime(){
    time = 30;
  }
 void displayTime(){
   fill(0);
   text(time, 40, 25);
 }
 int getTime(){
   return time;
 }
}
