float x=400;
float y=300;
float a=PI/2;
float r=30;
float d = radians(120);

PImage[] fly_images = new PImage[2];
PImage vene_img;
PImage airo_r_img;
PImage airo_rb_img;
PImage airo_l_img;
PImage airo_lb_img;

float spin=0;
final float wobbleAmplitude = 8;
final float wobbleFrequency = 0.25;
int score = 0;
int lastUpdateTime = 0;
float flyAngle = 0;
int flyIndex = 0;
float veneAngleDiff = 0;
float veneSpeed = 0;
float veneAngle = PI/2;
float xFly = 0;
float yFly = 0;
float laajentuminen = 10;
float aaltoX = 0;
float aaltoY = 0;

boolean left = false;
boolean right = false;
boolean leftBrake = false;
boolean rightBrake = false;


int lastFrameCount = 0;
float hiipuminen = 0;

float[] laajentuminenRight = new float[3];
float[] laajentuminenLeft = new float[3];
float[] hiipuminenRight = new float[3];
float[] hiipuminenLeft = new float[3];

int indexRight = 0;
int indexLeft = 0;


// -------------------------------------------------------------------------------

void setup () {
  size (800, 600);
  imageMode(CENTER);

  vene_img = loadImage("vene.png");

  airo_r_img = loadImage("airo_r.png");
  airo_rb_img = loadImage("airo_rb.png");
  airo_l_img = loadImage("airo_l.png");
  airo_lb_img = loadImage("airo_lb.png");

  fly_images[0] = loadImage("fly.png");
  fly_images[1] = loadImage("fly2.png");
}

// -------------------------------------------------------------------------------

void aallot (float offset, float arcStart, float arcEnd, float size) {
arc (aaltoX+cos(PI/2+PI/8-veneAngle)*offset, aaltoY+sin(PI/2+PI/8-veneAngle)*offset, size, size, -(veneAngle+arcStart), -(veneAngle+arcEnd)
  );
}



void keyPressed() {

  if (key == '4' && !left) {
    left = true;
    veneSpeed = veneSpeed+0.8;
    veneAngleDiff += -PI/180;
  } else if (key == '6' && !right) {
    right = true;
    veneSpeed = veneSpeed+0.8;
    veneAngleDiff += PI/180;
 //   hiipuminen = 255;
 //   aalto = 10;
    aaltoX = x;
    aaltoY = y;
    hiipuminenRight[indexRight] = 255;
    laajentuminenRight[indexRight] = 10;
    indexRight++;
    if (indexRight > 2) {
      indexRight = 0;
    }
  } else if (key == '9' && !rightBrake) {
    rightBrake = true;
    veneSpeed = veneSpeed-0.8;
    veneAngleDiff += -PI/180;
  } else if (key == '7' && !leftBrake) {
    leftBrake = true;
    veneSpeed = veneSpeed-0.8;
    veneAngleDiff += PI/180;
  } else if (key == '0') {
    x = width/2;
    y = height/2;
  }
}

void keyReleased() {
  if (key == '4') {
    left = false;
  }
  if (key == '6') {
    right = false;
  }
  if (key == '7') {
    leftBrake = false;
  }
  if (key == '9') {
    rightBrake = false;
  }
}

// -------------------------------------------------------------------------------

void draw () {
  background(#6699bb);
  noFill ();
//  strokeWeight(1);
//  stroke (255, hiipuminen);
// arc (aaltoX+cos(PI/2+PI/8-veneAngle)*63, aaltoY+sin(PI/2+PI/8-veneAngle)*63, laajentuminen, laajentuminen, -(veneAngle+PI*1.7), -(veneAngle+PI/2));

 // hiipuminen -= 5;
 // laajentuminen += 1;

for (int i = 0; i < 3; i++) {
stroke(255, hiipuminenRight[i]);
aallot(63, PI*1.7, PI/2, laajentuminenRight[i]);
laajentuminenRight[i] += 1;
hiipuminenRight[i] -=5;
}

  pushMatrix();
  translate(x, y);
  rotate(PI/2-veneAngle);
  image(vene_img, 0, 0);



  if (left) {
    image(airo_lb_img, 0, 0);
    veneSpeed *= 1 - 0.001 * veneSpeed;
    veneAngleDiff += (veneSpeed * 0.0002);
  } else {
    image(airo_l_img, 0, 0);
  }

  if (right) {
    image(airo_rb_img, 0, 0);
    veneSpeed *= 1 - 0.001 * veneSpeed;
    veneAngleDiff -= (veneSpeed * 0.0002);
  } else {
    image(airo_r_img, 0, 0);
  }
  if (leftBrake) {
    //image(airo_lb_img, 0, 0);
    veneSpeed *= 1 - 0.001 * veneSpeed;
    veneAngleDiff += (veneSpeed * 0.0000001);
  } //else {
  //image(airo_l_img, 0, 0);
  //}

  if (rightBrake) {
    //image(airo_rb_img, 0, 0);
    veneSpeed *= 1 - 0.001 * veneSpeed;
    veneAngleDiff -= (veneSpeed * 0.0000001);
  } //else {
  //image(airo_r_img, 0, 0);
  //}


  popMatrix();


  x = x+(veneSpeed * cos(veneAngle));
  y = y-(veneSpeed * sin(veneAngle));

  if (veneSpeed < 0 ) {
    veneSpeed *= 0.96;
  } else {
    veneSpeed *= 0.99;
  }
  veneAngleDiff = veneAngleDiff * 0.97;
  veneAngle = veneAngle + veneAngleDiff;


  // Calculate angle
  float targetAngle = atan2(y - yFly, x - xFly) + PI/2;

  float angleDiff = targetAngle - flyAngle;

  if (angleDiff > PI) {
    angleDiff -= 2 * PI;
  } else if (angleDiff < -PI) {
    angleDiff += 2 * PI;
  }

  xFly = (x * 0.01 + xFly * 0.99);
  yFly = (y * 0.01 + yFly * 0.99);

  // Rotate the image towards the target
  pushMatrix();
  translate(xFly, yFly);
  rotate(flyAngle);
  image(fly_images[flyIndex], (wobbleAmplitude * sin(a + frameCount * wobbleFrequency)) + ((wobbleAmplitude) * sin(a + frameCount * (wobbleFrequency/4))), ((wobbleAmplitude+8) * cos(a + frameCount * (wobbleFrequency/5)))+((wobbleAmplitude+3) * cos(a + frameCount * (wobbleFrequency/8))));
  //image(img, 0,0);
  popMatrix();

  flyIndex = (frameCount/3) % 2;
  flyAngle = normalizeAngle(flyAngle + angleDiff * 0.1);//

  /*
  // PISTELASKUSYSTEEMI
   
   int currentTime = millis();
   
   if (currentTime - lastUpdateTime >= 1000) {
   score=score+1;
   lastUpdateTime = currentTime;
   }
   
   fill(#FFFFFF);
   textSize(30);
   text("Score: "+score, 20, 40);
   */
}

float normalizeAngle(float a) { //selitä lisää
  if (a > 2*PI) {
    a -= 2 * PI;
  } else if (a < -2*PI) {
    a += 2 * PI;
  }
  return a;
}
