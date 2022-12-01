//initialize vars

int state = 0;

int score;
int winScore = 13;

PImage[] fireball = new PImage[4];
PImage[] enemy = new PImage[3];
PImage[] shrok = new PImage[4];

Animation fireballAnimation;
Animation enemyAnimation;
Animation shrokAnimation;

int spawnStart;
int shootStart;
int multStart;
int endStart;

int currentTime;
int spawnInterval;
int shootInterval;
int multiplierInterval;

int x;
int y;

boolean enemySpawn;
boolean enemyShoot;

import processing.sound.*;

SoundFile explodeSound;
SoundFile backgroundSound;

//declare vars

Player p1;
Enemy e1;
Enemy e2;


ArrayList <Bullet> bulletList;
ArrayList <EnemyBullet> enemyBulletList;
ArrayList <Enemy> enemyList;
ArrayList <Ball> ballList;



///////////////////////////////////////////////////////
//setup
//////////////////////////////////////////////////////



void setup() {
  size(1500, 800);


  imageMode(CENTER);

  //enemy animation
  for (int i=0; i<enemy.length; i++) {//i = i+1
    enemy[i] = loadImage("enemy_" + str(i) + ".png");
  }
  enemyAnimation = new Animation(enemy, .2, 2.5);
  enemyAnimation.isAnimating = true;

  //player animation
  for (int i=0; i<shrok.length; i++) {//i = i+1
    shrok[i] = loadImage("shrek_" + str(i) + ".png");
  }
  shrokAnimation = new Animation(shrok, .2, 5.5);

  //projectile
  for (int i=0; i<fireball.length; i++) {//i = i+1
    fireball[i] = loadImage("fireball_" + str(i) + ".png");
  }
  fireballAnimation = new Animation(fireball, .3, 6);


  x = width/2;
  y = height/2;
  score = 0;

  spawnStart = millis();
  shootStart = millis();
  multStart = millis();
  spawnInterval = 5000;
  shootInterval = 3000;
  multiplierInterval = 10000;
  println("program started");

  explodeSound = new SoundFile(this, "explode.wav");
  backgroundSound = new SoundFile(this, "KillBill.wav");

  explodeSound.amp(1.0); // volume
  explodeSound.rate(15.0); 


  p1 = new Player(width/2, height-150, 100, color(255));
  e1 = new Enemy(300, 200, 50, 100);
  e2 = new Enemy(600, 300, 50, 100);

  enemyList = new ArrayList<Enemy> ();
  enemyBulletList = new ArrayList<EnemyBullet>();
  ballList = new ArrayList<Ball> ();
  bulletList = new ArrayList<Bullet> ();


  enemyList.add(e1);
  enemyList.add(e2);
}



/////////////////////////////////////////////////
////draw
//////////////////////////////////////////////


void draw() {
  background(42);
  strokeWeight(0);
  
  //background noise

  if (backgroundSound.isPlaying()==false) {
    backgroundSound.play();
  }

//animations

  enemyAnimation.isAnimating = true;
  enemyAnimation.display();

  shrokAnimation.show();

  fireballAnimation.place();

//player movement

  p1.movement();
  
  //win conditions

  if (score == winScore) {
    state = 3;
  }

  //if (enemyList.size() == 0) {
  //  state = 3;
  //  enemyList.clear();
  //}


  /////////////////////////////////////////////////////////
  ///states
  /////////////////////////////////////////////////////////


  switch(state) {

    //main menu
  case 0:
    strokeWeight(10);
    stroke(255, 0, 0);
    line(0, height/3, height, height/3);
    stroke(255);
    textSize(100);
    text("BallDodge", width/8, 200);
    textSize(60);
    text("press 'e' for endless", width/8, height/2);
    text("take out 13 enemies to win", width/5, height*65/100);
    textSize(50);
    text("'w a s d' to move", 900, 200);
    text("'v' to shoot", 900, 300);
    break;

    //endless mode
  case 1:

    //balls
    for (Ball aBall : ballList) {
      aBall.render(); 
      p1.pickUpBall(aBall);

      if (aBall.shouldPickUp == true) {
        aBall.bx = p1.px;
        aBall.by = p1.py - 70;
      }
    }

    //shoot

    for (int i = ballList.size()-1; i>=0; i--) {
      if (keyPressed == true && ballList.get(i).shouldPickUp == true) {
        if (key == 'v') {
          fireballAnimation.Animating = true;
          bulletList.add(new Bullet(p1.px + p1.sideLength/10, p1.py));
          ballList.get(i).shouldPickUp = false;
          ballList.remove(ballList.get(i));
        }
      }
    }

    //enemy list

    for (Enemy anEnemy : enemyList) {
      //anEnemy.render();
      anEnemy.moveLtoR();
    }
    //bullet function

    for (Bullet aBullet : bulletList) {
      aBullet.render();
      aBullet.move();
      aBullet.checkRemove(); 

      for (Enemy anEnemy : enemyList) {
        aBullet.shootEnemy(anEnemy);
      }
    }

    //enemy bullet

    for (EnemyBullet anEnemyBullet : enemyBulletList) {
      anEnemyBullet.render();
      anEnemyBullet.move();
      anEnemyBullet.checkRemove(); 
      anEnemyBullet.windowCollision();
      anEnemyBullet.shootPlayer();
      if (anEnemyBullet.canAddBall == true) {
        ballList.add(new Ball(anEnemyBullet.x, anEnemyBullet.y -50));
      }
    }
    for (int i = enemyBulletList.size()-1; i>=0; i--) {
      if (enemyBulletList.get(i).canRemoveEnemyBullet == true) {
        enemyBulletList.remove(enemyBulletList.get(i));
      }
    }

    //enemy destroyed

    for (int i = enemyList.size()-1; i >= 0; i=i-1) {
      Enemy anEnemy = enemyList.get(i);

      if (anEnemy.shouldRemove == true) {
        enemyList.remove(anEnemy);
        explodeSound.play();
        score += 1;
        //bulletList.remove(aBullet);
      }
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    ///millis timer
    //////////////////////////////////////////////////////////////////////////////////////////////////

    currentTime = millis();

    //timer if statement

    if (currentTime - spawnStart >= spawnInterval) {
      enemyList.add(new Enemy(int(random(0, width)), int(random(0, height*1/3)), 50, 100));

      enemySpawn = true;

      println("enemySpawn");

      spawnStart = millis();
    }

    if (currentTime - shootStart >= shootInterval) {
      Enemy shootingEnemy = enemyList.get(int(random(0, enemyList.size())));
      enemyBulletList.add(new EnemyBullet(shootingEnemy.x, shootingEnemy.y));

      enemyShoot = true;

      println("enemyShoot");

      shootStart = millis();
    }

    if (currentTime - multStart >= multiplierInterval) {
      shootInterval = shootInterval * 3/10;
      spawnInterval = spawnInterval * 3/10;

      println("multiplied");

      multStart = millis();
    }

    /////////////////////////////////////////////////////////////////////////////////////
    //end of millis timer
    ////////////////////////////////////////////////////////////////////////////////////
    break;

    //lose screen
  case 2:

    background(0);
    fill(255, 0, 0);
    textSize(90);
    text("Game Over", width/8, height/2);
    textSize(70);
    text("'m' for menu", width/8, height*3/4);
    enemyBulletList.clear();
    score = 0;
    spawnInterval = 3000;
    shootInterval = 3000;
    multiplierInterval = 10000;
    ballList.clear();
    enemyAnimation.isAnimating = false;
    p1.px = width/2;
    p1.py = height - 150;
    enemyList.clear();
    enemyList.add(e1);
    enemyList.add(e2);
    break;

    ///win screen
  case 3:
    background(0);
    fill(200, 255, 0);
    textSize(90);
    text("You Win!", width/8, height/2);
    textSize(70);
    text("'m' for menu", width/8, height*3/4);
    enemyBulletList.clear();
    score = 0;
    spawnInterval = 5000;
    shootInterval = 3000;
    multiplierInterval = 10000;
    ballList.clear();
    enemyAnimation.isAnimating = false;
    Enemy e1;
    Enemy e2;
    e1 = new Enemy(300, 200, 50, 100);
    e2 = new Enemy(600, 300, 50, 100);
    enemyList.add(e1);
    enemyList.add(e2);
    p1.px = width/2;
    p1.py = height - 150;
    break;
  }
}


///////////////////////////////////////////////////////
////key bindings
//////////////////////////////////////////////////////


void keyPressed() {

  if (key == 'm') {
    state = 0;
  }

  //if (key == 'z') {
  //  state = 3;
  //}

  if (key == 'u') {
    enemyList.add(new Enemy(int(random(0, 500)), int(random(0, 500)), 50, 100));
  }

  if (key == 'e') {
    state = 1;
  }
  if (key == 't') {
    state = 2;
  }
  if (key == 'w') {
    p1.isMovingUp = true;
    shrokAnimation.Animating = true;
  }

  if (key == 's') {
    p1.isMovingDown = true;
    shrokAnimation.Animating = true;
  }

  if (key == 'd') {
    p1.isMovingRight = true;
    shrokAnimation.Animating = true;
  }

  if (key == 'a') {
    p1.isMovingLeft = true;
    shrokAnimation.Animating = true;
  }
}

void keyReleased() {
  if (key == 'w') {
    p1.isMovingUp = false;
    shrokAnimation.Animating = false;
  }

  if (key == 's') {
    p1.isMovingDown = false;
    shrokAnimation.Animating = false;
  }

  if (key == 'd') {
    p1.isMovingRight = false;
    shrokAnimation.Animating = false;
  }

  if (key == 'a') {
    p1.isMovingLeft = false;
    shrokAnimation.Animating = false;
  }
}
