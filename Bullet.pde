class Bullet {
  float x;
  float y;
  float relx;
  float rely;
  
  float angle;
  float speed;
  float total_disp;
  
  Bullet () {
    x = A1.x; // initial position of bullet starting at the site where its fired
    y = A1.y;
    relx = A1.disp[0]; // speed of arrow in x
    rely = A1.disp[1]; // speed of arrow in y
    angle = A1.angle_point;
    speed = 1500;
    total_disp = 0;
  }
  
  void draw () {
    displacement();
    visual();
  }
  
  // calculates displacement as well as adding to the total distance the bullet has traveled
  void displacement () {
    float disp [] = {relx + speed*dt*sin(angle), rely + speed*dt*cos(angle)}; // calculated initally relative to arrow itself
    x += disp[0]; y += disp[1];
    
    total_disp += sqrt(sq(disp[0]) + sq(disp[1]));  // total displacement of bullet
    
    if (x > width) {
      x -= width;
    }
    if (x < 0) {
      x += width;
    }
    if (y > height) {
      y -= height;
    }
    if (y < 0) {
      y += height;
    }
  } 
   
  // draws bullet visual in the form of a small white circle
  void visual () {
    circle(x, y, 10);
  }
}
