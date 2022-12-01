class Enemy {

  //variables

  int x;
  int y;
  int w;
  int h;

  int xSpeed;
  int ySpeed;

  int left;
  int right;
  int top;
  int bottom;

  boolean shouldRemove;

  //constructor

  Enemy(int startingX, int startingY, int startingW, int startingH) {
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;

    xSpeed = 10;
    ySpeed = 0;

    shouldRemove = false;
  }

  //function

  void render() {
    fill(255);
    rectMode(CENTER);
    rect(x, y, w, h);
  }

  void moveLtoR() {
    x -= xSpeed;

    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;

    if (x < 100) {
      xSpeed --;
    }
    if (x > width-100) {
      xSpeed ++;
    }
  }
}
