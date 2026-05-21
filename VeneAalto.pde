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
        veneAaltoHimmennys = _veneSpeed * 100;
    }

    void update() {
        veneLaajentuminen += 1;
        veneAaltoHimmennys -= 1;
    }   

    void show() {

        

        stroke (255, veneAaltoHimmennys);
        ellipse(veneX,veneY,40 + veneLaajentuminen,85 + veneLaajentuminen);
    }

}

