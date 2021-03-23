arrow A1 = new arrow ();

float dt = 1.0/60.0;
float bullet_delay = 0.0;

// the maximum speed the circle can go
float max = 5; // currently not being used, is in class "Arrow" atm, move it over to here
float bullet_range = 1200;

// initializing keys input storage
boolean[] keys;
boolean spaceKey;

ArrayList <Bullet> bullets;

void setup () {
  size(1600, 800);
  
  bullets = new ArrayList();
  A1 = new arrow();
  
  keys = new boolean [4];
  keys[0] = false;
  keys[1] = false;
  keys[2] = false;
  keys[3] = false;
}

void draw () {
  frameRate(60);
  background(0);

  // if the space key is pressed, a new bullet will be added to the array list
  // only if there has been a delay from the last time a bullet has been added
  if (spaceKey == true && bullet_delay >= 0.2) {
    bullets.add(new Bullet());
    bullet_delay = 0; // resets the delay timer when bullet added
  } bullet_delay += dt; // increments bullet timer
  
  // goes through the array list backwards and removes bullets further than bullet range
  for (int i = bullets.size() - 1; i >=0; i--) {
    Bullet bullet = bullets.get(i);
    if (bullet.total_disp >= bullet_range) {
      bullets.remove(i);
    }
  }
  
  // draws all bullets currently in the arrayList
  for(Bullet bullet : bullets) bullet.draw();
  
  A1.displacement(keys[0], keys[2], keys[1], keys[3]); // sends key data to Arrow class
  A1.visual(); // draws the actual arrow
  
  println(bullets.size());  
}

// detects which keys are pressed, and which keys are released
void keyPressed() {
  
  // when keys are pressed, they are activated until they are released
  if (key == 'w'){
    keys[0] = true;
  }
  if (key == 'a'){
    keys[1] = true;
  }
  if (key == 's'){
    keys[2] = true;
  }
  if (key == 'd'){
    keys[3] = true;
  }
  if (key == ' '){
    spaceKey = true;
  }
}

void keyReleased() {
  if (key == 'w'){
    keys[0] = false;
  }
  if (key == 'a'){
    keys[1] = false;
  }
  if (key == 's'){
    keys[2] = false;
  }
  if (key == 'd'){
    keys[3] = false;  
  }
  if (key == ' '){
    spaceKey = false;
  }
}
