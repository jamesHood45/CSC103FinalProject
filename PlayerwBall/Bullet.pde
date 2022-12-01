class Bullet {


  //variables

  int x;
  int y;
  int d;
  int speed;

  boolean shouldRemove;

  boolean hasStopped;

  int left;
  int right;
  int top;
  int bottom;

  //constructor

  Bullet(int startingX, int startingY) {
    x = startingX;
    y = startingY;

    d = 70;

    speed = 15;

    shouldRemove = false;

    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }

  //function

  void render() {
    fill(255,0,0);
    circle(x, y, d);
  }

  void move() {
    y -= speed;

    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }

  void checkRemove() {
    if (y < 0) {
      shouldRemove = true;
    }
  }

  void shootEnemy(Enemy anEnemy) {
    if (top <= anEnemy.bottom &&
      bottom >= anEnemy.top &&
      left <= anEnemy.right &&
      right >= anEnemy.left) {
      anEnemy.shouldRemove = true;
    }
  }

  //expermental

  

  void windowCollision() {
    if ((y + d/2 > height) || (y + d/2 < 0)) {
      speed = speed * -1;
    }
  }

  void returnBall() {
    //  E  Bullet hittingWall = bulletList.get(Bullet.x, Bullet.y)));
    //bulletList.add(new Bullet(shootingEnemy.x, shootingEnemy.y));

//    if(hasStopped == true){
//      ballList.add(new Ball(x, y));
//      d = 0;
//    }
//    if ( (y + d/2 >= height) || (y + d/2 <= 0) ) {
//      hasStopped = true;
//     // ballList.add(b3);
//      if (ballList.add(b3)) {
//        hasStopped = false;
//      }
//    }
  }
}
