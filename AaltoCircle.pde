class AaltoCircle {

  float x;
  float y;
  float laajentuminen;
  float angle;
  float aaltoHimmennys;

  AaltoCircle(float _x, float _y, float _angle, float _veneSpeed) {
    x = _x;
    y = _y;
    angle = _angle;
    laajentuminen = 0;
    aaltoHimmennys = _veneSpeed * 8;
  }

  void update() {
    laajentuminen += 2;
    aaltoHimmennys -= 0.5;
    if (aaltoHimmennys < 0) {
      aaltoHimmennys = 0;
      laajentuminen = 0;
    }
  }

  void show() {
    pushMatrix();
    translate(x, y);
    rotate(PI/2-angle);
    stroke (255, aaltoHimmennys);
    ellipse(0, 0, 45 + laajentuminen, 85 + laajentuminen);
    popMatrix();
  }
}
