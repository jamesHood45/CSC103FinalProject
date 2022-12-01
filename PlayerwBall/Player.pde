class Player {

  //variables
  
  int px;
  int py;
  int sideLength;
  int speed;

  color fillC;

  boolean isMovingUp;
  boolean isMovingDown;
  boolean isMovingLeft;
  boolean isMovingRight;

  boolean shouldPickUp = false;


  int left;
  int right;
  int top;
  int bottom;

  //construction

  Player(int aX, int aY, int aL, color aFillC) {
    px = aX;
    py = aY;
    sideLength = aL;
    fillC = aFillC;

    left = px - sideLength/3;
    right = px + sideLength/3;
    top = py- sideLength/3;
    bottom = py + sideLength/3;

    speed = 15;

    isMovingUp = false;
    isMovingDown = false;
    isMovingLeft = false;
    isMovingRight = false;
  }

  //function
  
  void drawPlayer() {
    fill(fillC);
    circle(px, py, sideLength);
  }

  void pickUpBall(Ball aBall) {

    if (top <= aBall.bottom) {
      if (bottom >= aBall.top) {
        if (left <= aBall.right) {
          if (right >= aBall.left) {
            aBall.shouldPickUp = true;
          }
        }
      }
    }   
  }

  void movement() {

    if (isMovingUp == true) {
      py -= speed; //y= y - speed;
    }
    if (isMovingDown == true) {
      py += speed; //y= y + speed;
    }
    if (isMovingLeft == true) {
      px -= speed; //y= y - speed;
    }
    if (isMovingRight == true) {
      px += speed; //y= y + speed;
    }

    left = px - sideLength/2;
    right = px + sideLength/2;
    top = py - sideLength/2;
    bottom = py + sideLength/2;
  }
}
