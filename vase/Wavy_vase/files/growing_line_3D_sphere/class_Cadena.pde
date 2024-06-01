class Cadena {

  ArrayList<Punto> puntos;
  ArrayList<Muelle> muelles;

  Cadena() {
    puntos = new ArrayList<Punto>();
    muelles = new ArrayList<Muelle>();
  }

  void init() {
    for (int i=0; i<360; i+=72) {
      float r = random(5, 5);
      float x = r*cos(radians(i));
      float y = r*sin(radians(i));
      this.puntos.add(new Punto(x, y, false));
    }
    for (int i=0; i<cad.puntos.size(); i++) {
      Punto p0 = this.puntos.get(i);
      Punto p1 = this.puntos.get((i+1) % this.puntos.size());
      this.muelles.add(new Muelle(p0, p1, dist, elast));
    }
  }
  void update() {
    updateCentro();
    for (int i=0; i<muelles.size(); i++) {
      muelles.get(i).update();
    }

    for (int i=0; i<puntos.size(); i++) {
      Punto p1 = puntos.get(i);

      for (int p=0; p<puntos.size(); p++) {
        Punto p2 = puntos.get(p);
        if (i != p) {
          PVector rel = PVector.sub(p1.pos, p2.pos);
          float d = rel.mag();
          if (d < collisionDist) {
            p1.fuerza.add(rel.mult(1/(d+0.001)));
          }
        }
      }
      // añade expansión
      float ex, ey, ang, g;
      PVector pv = PVector.sub(p1.pos, centro);
      ang = atan2(pv.y, pv.x);
      g = expansion / (pv.mag()+1);
      ex = g*cos(ang);
      ey = g*sin(ang);
      p1.fuerza.add(ex, ey);

      if (bugged) {
        // actualiza según calcula (no debería ser así pero salen resultados chulos)
        p1.update();
        p1.fuerza.mult(0);
      }
    }

    if (!bugged) {
      // supuestamente la manera correcta de actualizar
      for (int i=0; i<puntos.size(); i++) {
        Punto p1 = puntos.get(i);
        p1.update();
        p1.fuerza.mult(0);
      }
    }
  }
  void updateCentro() {
    PVector suma = new PVector(0, 0);
    for (int i=0; i<puntos.size(); i++) {
      suma.add(puntos.get(i).pos);
    }
    suma = suma.div(puntos.size());
    centro = suma;
  }
  void addPunto() {
    // selecciono un muelle random
    int ind = randomIndice(0, this.muelles.size()-1);

    Muelle m = this.muelles.get(ind);
    Punto p1 = m.p1;
    Punto p2 = m.p2;

    float xx = (p1.pos.x+p2.pos.x) / 2;
    float yy = (p1.pos.y+p2.pos.y) / 2;
    this.puntos.add(ind+1, new Punto(xx, yy, false));
    Punto pn = this.puntos.get(ind+1);
    m.p2 = pn;
    this.muelles.add(ind+1, new Muelle(pn, p2, dist, elast));
  }

  void deletePunto() {
    // selecciono un muelle random
    int ind = floor(random(0, this.muelles.size()-1));

    // Cambio los puntos del siguiente muelle al que voy a borrar
    // Borro muelle (ind)
    this.muelles.remove(ind);
    // borro punto (ind+1)
    this.puntos.remove(ind+1);
    Muelle mnext = this.muelles.get(ind);
    mnext.p1 = this.puntos.get(ind);
  }

  int randomIndice(int minimo, int maximo) {
    //int ind = floor(random(minimo,maximo));
    int ind = (minimo+floor( noise(contador*noisezoom) * (maximo*2) )) % maximo;
    //int ind = (maximo / 6) * floor(random(6+1));   

    return ind;
  }

  void dibuja() {
    strokeWeight(1);
    stroke(255, 140);
    fill(0);

    //beginShape();
    for (int i=0; i<muelles.size(); i++) {
      Muelle m = muelles.get(i);
      Punto p0 = m.p1;
      Punto p1 = m.p2;
      line(p0.pos.x, p0.pos.y, p1.pos.x, p1.pos.y);
      //      vertex(p0.pos.x, p0.pos.y);
    }
    // endShape(CLOSE);

    strokeWeight(1);
    stroke(0);
    fill(255);
    beginShape();
    for (int i=0; i<puntos.size(); i++) {
      Punto p0 = puntos.get(i);
      // ellipse(p0.pos.x, p0.pos.y, 4, 4);
      vertex(p0.pos.x, p0.pos.y);
    }
    endShape(CLOSE);
  }
}