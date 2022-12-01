class EnemyBullet {


  //variables

  int x;
  int y;
  int d;
  int speed;

  boolean shouldRemove;

  boolean canAddBall;
  boolean canRemoveEnemyBullet;

  int left;
  int right;
  int top;
  int bottom;

  //constructor

  EnemyBullet(int startingX, int startingY) {
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
    y += speed;

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

  void shootPlayer(Player aPlayer) {
    if (top <= aPlayer.bottom &&
      bottom >= aPlayer.top &&
      left <= aPlayer.right &&
      right >= aPlayer.left) {
      state = 2;
    }
  }

  void windowCollision() {
    if (y  > height){
     canAddBall = true;
     canRemoveEnemyBullet = true;
    }
    
  }

  void returnBall() {
    
     
  }
  
  void shootPlayer() {
    if (top <= p1.bottom &&
      bottom >= p1.top &&
      left <= p1.right &&
      right >= p1.left) {
      state = 2;
      
    }
  }
}
