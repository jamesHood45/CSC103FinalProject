class Ball {
  
  //variables

  int bx;
  int by;
  int bd;

  int left;
  int right;
  int top;
  int bottom;

int ySpeed;

  boolean shouldPickUp;

  //construction
  
  Ball(int startingX, int startingY) {
    bx = startingX;
    by = startingY;
    bd = 70;
    
    ySpeed = 10;

    shouldPickUp = false;


    left = bx - bd/2;
    right = bx + bd/2;
    top = by - bd/2;
    bottom = by + bd/2;
  }

  //funtion

  void render() {
    fill(255,0,0);
    circle(bx, by, bd);
  }
  
  void moveBall(){
  //bx = bx + xSpeed;
  by = by - ySpeed;
}
}
