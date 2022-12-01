class Animation {
  // variables
  PImage[] images;
  float speed;
  float scale;

  float index;
  boolean isAnimating;
 
  boolean Animating;

  // constructor
  Animation(PImage[] tempImages, float tempSpeed, float tempScale) {
    images = tempImages;
    speed = tempSpeed;
    scale = tempScale;

    index = 0;
    isAnimating = false;
  }

  // updates the index which image to display for
  // the animation
  void next() {
    //println(index);
    index += speed;

    // resets the index if it is too big
    if (index >= images.length) {
      index=0;
      isAnimating=false;
    }
  }

  // display an image of the animation
  void display() {
    imageMode(CENTER);
    if (isAnimating) {
      int imageIndex = int(index);
      PImage img = images[imageIndex];
      for(Enemy anEnemy : enemyList){
      image(img, anEnemy.x, anEnemy.y, img.width*scale, img.height*scale);
      }
      // increment the index of the images to display
      next();
    } else {
      
      PImage img = images[1];
      for(Enemy anEnemy : enemyList){
      image(img, anEnemy.x, anEnemy.y, img.width*scale, img.height*scale);
      }
    }
  }
  void show() {
    imageMode(CENTER);
    if (Animating) {
      int imageIndex = int(index);
      PImage img = images[imageIndex];
     
      image(img, p1.px, p1.py, img.width*scale, img.height*scale);
      
      // increment the index of the images to display
      next();
    } else {
      
      PImage img = images[1];
     
      image(img, p1.px, p1.py, img.width*scale, img.height*scale);
      
    }
  }
  
  void place() {
    imageMode(CENTER);
    if (Animating) {
      int imageIndex = int(index);
      PImage img = images[imageIndex];
 for(Bullet aBullet : bulletList){    
      image(img, aBullet.x + 13, aBullet.y, img.width*scale, img.height*scale);
 }
      // increment the index of the images to display
      next();
    } else {
      
      PImage img = images[1];
     for(Bullet aBullet : bulletList){
      image(img, aBullet.x + 13, aBullet.y, img.width*scale, img.height*scale);
     }
    }
  }
}
