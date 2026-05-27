class AaltoPoint {

    float x;
    float y;
    float laajentuminenXleft;
    float laajentuminenXright;
    float laajentuminenY;
    float veneAngle;
    float aaltoHimmennys;
    float aaltoWobble;

    AaltoPoint(float _x, float _y, float _angle, float _veneSpeed, float _aaltoWobble) {
        x = _x;
        y = _y;
        veneAngle = _angle;
        laajentuminenXleft = 0;
        laajentuminenXright = 0;
        laajentuminenY = 0;
        aaltoHimmennys = _veneSpeed * 40;
        aaltoWobble = _aaltoWobble;
        //veneAaltoHimmennys = 255;
    }


    void updateR() {
        laajentuminenXright += 0.35 * veneSpeed;
        laajentuminenY += 0;
        aaltoHimmennys -= 0;
        if (aaltoHimmennys < 0) {
            aaltoHimmennys = 0;
            laajentuminenXright = 0;
            laajentuminenY = 0;
        }
    }


    void showR() {
    pushMatrix();
    translate(x, y);
    rotate(PI/2-veneAngle);        
    stroke (255, aaltoHimmennys-20);
    strokeWeight(2);
    point (21+laajentuminenXright,-32+laajentuminenY+aaltoWobble);
    popMatrix();
    }
    
    void updateL() {
        laajentuminenXleft -= 0.35 * veneSpeed;
        laajentuminenY += 0;
        aaltoHimmennys -= 2.5;
        if (aaltoHimmennys < 0) {
            aaltoHimmennys = 0;
            laajentuminenXleft = 0;
            laajentuminenY = 0;
        }
    }
    
    void showL() {
    pushMatrix();
    translate(x, y);
    rotate(PI/2-veneAngle);        
    stroke (255, aaltoHimmennys-20);
    strokeWeight(2);
    point (-21+laajentuminenXleft,-32+laajentuminenY+aaltoWobble);
    popMatrix();
    }
}