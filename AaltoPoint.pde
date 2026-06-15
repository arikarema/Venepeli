class AaltoPoint {

    float x;
    float y;    
    float xDelay;
    float yDelay;
    float laajentuminenXleft;
    float laajentuminenXleft2;
    float laajentuminenXright;
    float laajentuminenXright2;
    float veneAngle;
    float aaltoHimmennys;
    float aaltoWobble;

    AaltoPoint(float _x, float _y, float _xDelay, float _yDelay, float _angle, float _veneSpeed, float _aaltoWobble) {
        x = _x;
        y = _y;
        xDelay = _xDelay;
        yDelay = _yDelay;
        veneAngle = _angle;
        laajentuminenXleft = 0;
        laajentuminenXleft2 = 0;
        laajentuminenXright = 0;
        laajentuminenXright2 = 0;
        aaltoHimmennys = _veneSpeed * 40;
        aaltoWobble = _aaltoWobble;
        //veneAaltoHimmennys = 255;
    }


    void updateR() {
        laajentuminenXright += 0.35 * veneSpeed;
        laajentuminenXright2 += 0.5 * veneSpeed;
        aaltoHimmennys -= 0;
        if (aaltoHimmennys < 0) {
            aaltoHimmennys = 0;
            laajentuminenXright = 0;
            laajentuminenXright2 = 0;

        }
    }


    void showR() {
    pushMatrix();
    translate(xDelay, yDelay);
    rotate(PI/2-veneAngle);        
    stroke (255, aaltoHimmennys-20);
    strokeWeight(2);
    point (21+laajentuminenXright,-32+aaltoWobble);
    popMatrix();
    }

    void showR2() {
    pushMatrix();
    translate(xDelay, yDelay);
    rotate(PI/2-veneAngle);        
    stroke (255, aaltoHimmennys-70);
    strokeWeight(2);
    point (23+laajentuminenXright2,-42+aaltoWobble);
    popMatrix();
    }

    void showR3() {
    pushMatrix();
    translate(x, y);
    rotate(PI/2-veneAngle);  
    stroke (255, aaltoHimmennys);
    strokeWeight(2);
    point (63,21+aaltoWobble);
    popMatrix();
    }
    
    void updateL() {
        laajentuminenXleft -= 0.35 * veneSpeed;
        laajentuminenXleft2 -= 0.5 * veneSpeed;
        aaltoHimmennys -= 2.5;
        if (aaltoHimmennys < 0) {
            aaltoHimmennys = 0;
            laajentuminenXleft = 0;
            laajentuminenXleft2 = 0;

        }
    }
    
    void showL() {
    pushMatrix();
    translate(xDelay, yDelay);
    rotate(PI/2-veneAngle);        
    stroke (255, aaltoHimmennys-20);
    strokeWeight(2);
    point (-21+laajentuminenXleft,-32+aaltoWobble);
    popMatrix();
    }

    void showL2() {
    pushMatrix();
    translate(xDelay, yDelay);
    rotate(PI/2-veneAngle);        
    stroke (255, aaltoHimmennys-70);
    strokeWeight(2);
    point (-23+laajentuminenXleft2,-42+aaltoWobble);
    popMatrix();
    }
}