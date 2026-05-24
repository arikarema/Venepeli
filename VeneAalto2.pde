class VeneAalto2 {

    float veneX;
    float veneY;
    float veneLaajentuminen;
    float veneLaajentuminenX;
    float veneLaajentuminenY;
    float veneAngle;
    float veneAaltoHimmennys;
    float aaltoWobble;

    VeneAalto2(float _x, float _y, float _angle, float _veneSpeed, float _aaltoWobble) {
        veneX = _x;
        veneY = _y;
        veneAngle = _angle;
        veneLaajentuminen = 0;
        veneLaajentuminenX = 0;
        veneLaajentuminenY = 0;
        veneAaltoHimmennys = _veneSpeed * 40;
        aaltoWobble = _aaltoWobble;
        //veneAaltoHimmennys = 255;
    }
/*
    void update() {
        veneLaajentuminen += 2;
        veneAaltoHimmennys -= 1;
        if (veneAaltoHimmennys < 0) {
            veneAaltoHimmennys = 0;
            veneLaajentuminen = 0;
        }
    }   
*/

    void update2() {
        veneLaajentuminenX -= 0.35 * veneSpeed;
        veneLaajentuminenY += 0;
        veneAaltoHimmennys -= 2.5;
        if (veneAaltoHimmennys < 0) {
            veneAaltoHimmennys = 0;
            veneLaajentuminenX = 0;
            veneLaajentuminenY = 0;
        }
    }
/*
    void show() {
    pushMatrix();
    translate(veneX, veneY);
    rotate(PI/2-veneAngle);        
    stroke (255, veneAaltoHimmennys);
    ellipse(0,0,40 + veneLaajentuminen,85 + veneLaajentuminen);
    popMatrix();
    }

}
*/

    void show2() {
    pushMatrix();
    translate(veneX, veneY);
    rotate(PI/2-veneAngle);        
    stroke (255, veneAaltoHimmennys);
    strokeWeight(2);
    point (-23+veneLaajentuminenX,-25+veneLaajentuminenY+aaltoWobble);
    popMatrix();
    }
}