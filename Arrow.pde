class arrow {
  float x; 
  float y;
  
  float size; // determines size of the arrow
  
  float a;
  float a_frict; // friction factor while object is in motion
  float speed; // this is a pre-max adjusted speed, so doesnt actually display the real speed of the object
  float [] v;
  float [] disp;
  
  float max; // speed limit of the arrow
  
  float angle_accel; // angle at which acceleration is applied
  float angle_drift; // angle at which the object drifts
  float angle_point; // angle that the arrow points towards
  float rot_speed;   // rotation speed of the arrow when turned
  
  // constructor for new arrow
  arrow () {
    x = width/2;
    y = height/2;
    size = 12;
    angle_accel = PI;
    angle_drift = PI;
    angle_point = PI;
    rot_speed = 5*PI/3;
    speed = 0;
    max = 800;
    a_frict = -100;
    v = new float [2];
    disp = new float [2];
  }
  
  // function calculating displacement of arrow
  void displacement (boolean W, boolean S, boolean A, boolean D) {
    
    // adjusting acceleration based on input
    a = (int(W) - int(S))*(500);
    
    // adjusting angle of arrow
    angle_point += (int(A) - int(D))*(rot_speed)*dt;
    if (W == true || S == true) {
      angle_accel = angle_point; // when thrust is asked for, its applied in same direction arrow points
    }
   
    // calculates the angle at which the arrow is drifting at
    if (speed != 0) {
      angle_drift = acos(v[0]/speed) + PI/2;
    } else if (speed == 0) {
      angle_drift = 0;
    }   
    // corrects angle for bottom half
    if (v[1] > 0) {
      angle_drift = PI - angle_drift;
    }
    
    // ensuring angle remains 0 <= angle <= 2*PI  
    angle_accel = angle_adjust(angle_accel);
    angle_drift = angle_adjust(angle_drift);
    angle_point = angle_adjust(angle_point);
    
    // updates speed using acceleration in the x and y components
    // friction factor is constantly calculated for, but for some reason accounts for itself as speeds approach zero
    // keep an eye on this
    v[0] += sin(angle_accel)*a*dt + sin(angle_drift)*a_frict*dt;
    v[1] += cos(angle_accel)*a*dt + cos(angle_drift)*a_frict*dt;
    speed = sqrt(sq(v[0]) + sq(v[1])); // pre-adjusted calculation
    
    // scales down actual speed to the desired speed
    if (speed > max) {
      v[0] = v[0]*(max/speed);
      v[1] = v[1]*(max/speed);
    }
       
    // calculates displacement over dt in x and y components
    // also accounts for friction factor acceleration in displacement, although it is negligible
    disp[0] = v[0]*dt + a*sin(angle_accel)*sq(dt) + a_frict*sin(angle_drift)*sq(dt);  // displacement in x
    disp[1] = v[1]*dt + a*cos(angle_accel)*sq(dt) + a_frict*cos(angle_drift)*sq(dt);  // displacement in y
    
    // implements displacement and updates object coordinates
    x += disp[0]; y += disp[1];
    
    // the arrow travels through borders onto the other side - "scrolls" through the screen
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
  
  // draws the arrow shape itself
  void visual () {
    triangle(x + size*sin(angle_point+2*PI/3), y + size*cos(angle_point+2*PI/3),
    x + (5/2)*size*sin(angle_point), y + (5/2)*size*cos(angle_point),        // arrow point is scaled up by a factor of 5/2
    x + size*sin(angle_point-2*PI/3), y + size*cos(angle_point-2*PI/3));
  }
}

float angle_adjust (float a) {
  if (a < 0) {
    a += 2*PI;
  } else if (a > 2*PI) {
    a -= 2*PI;
  } return a;  
}
