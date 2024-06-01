class Muelle{
  Punto p1;
  Punto p2;
  float longitud;
  float elasticidad;
    
  Muelle(Punto p1,Punto p2,float l,float e){
    this.p1 = p1;
    this.p2 = p2;
    longitud = l;
    elasticidad = e;
  }
  
  void update(){
    PVector vecAB = PVector.sub(this.p2.pos, this.p1.pos);
    float forceMag = this.elasticidad*(this.longitud-vecAB.mag());
    PVector forceAB = vecAB.setMag(forceMag);
    PVector forceBA = PVector.mult(forceAB,-1);
    this.p1.fuerza.add(forceBA);
    this.p2.fuerza.add(forceAB);    
  }
  
}