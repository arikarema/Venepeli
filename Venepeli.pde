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


boolean left = false;
boolean right = false;
boolean leftBrake = false;
boolean rightBrake = false;


int lastFrameCount = 0;

float[] laajentuminen = new float[10];
float[] hiipuminen = new float[10];
float[] aaltoX = new float [10];
float[] aaltoY = new float [10];
float[] aaltoAngle = new float [10];
int aaltoIndex = 0;


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

void drawAalto(float positionX, float positionY, float angle, float size, float alpha) {
  stroke(255, alpha);
  float aaltoWidth = radians(110);
  arc (positionX, positionY, size, size, (angle+PI-aaltoWidth), (angle+PI+aaltoWidth));
}

void createAalto(float ax, float ay, float angle) {
    aaltoX[aaltoIndex] = ax;
    aaltoY[aaltoIndex] = ay;
    hiipuminen[aaltoIndex] = 255;
    laajentuminen[aaltoIndex] = 10;
    aaltoAngle[aaltoIndex] = angle;
    aaltoIndex++;
    if (aaltoIndex > 9) {
      aaltoIndex = 0;
    }
}

void keyPressed() {

  if (key == '4' && !left) {
    left = true;
    veneSpeed = veneSpeed+0.8;
    veneAngleDiff += -PI/180;

    float a = veneAngle+PI/2;
    createAalto(x + cos(a)*63, y  - sin(a)*63, -veneAngle+radians(30));

  } else if (key == '6' && !right) {
    right = true;
    veneSpeed = veneSpeed+0.8;
    veneAngleDiff += PI/180;

    float a = veneAngle-PI/2;
    createAalto(x + cos(a)*63, y  - sin(a)*63, -veneAngle-radians(30));

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
    veneAngle = PI/2;
    veneSpeed = 0;
    veneAngleDiff = 0.0;
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

  for (int i = 0; i < hiipuminen.length; i++) {
    if (hiipuminen[i] <= 0) continue;
    // continue jatkaa suoraan luuppia seuraavalla kierroksella
    // break lopettaa luupin suoraan
    drawAalto(aaltoX[i], aaltoY[i], aaltoAngle[i], laajentuminen[i], hiipuminen[i]);
    laajentuminen[i] += 1;
    hiipuminen[i] -= 1;
  }



  pushMatrix();
  translate(x, y);
  rotate(PI/2-veneAngle);

float aaltoWobble = sin(frameCount * 0.1);
  stroke (255);
  arc (0, aaltoWobble * 2 + 100, aaltoWobble *2 + 80, 300, -veneAngle - radians(90), -veneAngle + radians(90));
  arc (0, aaltoWobble * 2   + 80, aaltoWobble *2 + 70, 120, -veneAngle - radians(80), -veneAngle + radians(80));
  arc (0 , aaltoWobble * 2 + 100, aaltoWobble *2 + 60, 120, -veneAngle - radians(90), -veneAngle + radians(90));
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

  popMatrix();

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
