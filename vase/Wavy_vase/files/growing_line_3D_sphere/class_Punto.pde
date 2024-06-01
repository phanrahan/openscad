class Punto {
  PVector pos, vel, acc, fuerza;
  float m = 1;
  boolean fijo = false;
  float arrastra = 0.8;

  Punto(float x, float y, boolean fijo) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    fuerza = new PVector(0, 0);
    this.fijo = fijo;
    m = 1;
  }

  void update() {
    if (!this.fijo) {
      this.acc = this.fuerza.div(this.m);
      this.vel.add(PVector.mult(this.acc,dt));
      this.pos.add(PVector.mult(this.vel,dt));
      this.vel.mult(this.arrastra);
    }
    
    
  }
}