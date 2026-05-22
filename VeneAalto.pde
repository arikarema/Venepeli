class VeneAalto {

    float veneX;
    float veneY;
    float veneLaajentuminen;
    float veneAngle;
    float veneAaltoHimmennys;

    VeneAalto(float _x, float _y, float _angle, float _veneSpeed) {
        veneX = _x;
        veneY = _y;
        veneAngle = _angle;
        veneLaajentuminen = 0;
        veneAaltoHimmennys = _veneSpeed * 20;
        //veneAaltoHimmennys = 255;
    }

    void update() {
        veneLaajentuminen += 2;
        veneAaltoHimmennys -= 1;
        if (veneAaltoHimmennys < 0) {
            veneAaltoHimmennys = 0;
            veneLaajentuminen = 0;
        }
    }   

    void show() {
    pushMatrix();
    translate(veneX, veneY);
    rotate(PI/2-veneAngle);        
    stroke (255, veneAaltoHimmennys);
    ellipse(0,0,40 + veneLaajentuminen,85 + veneLaajentuminen);
    popMatrix();
    }

}

