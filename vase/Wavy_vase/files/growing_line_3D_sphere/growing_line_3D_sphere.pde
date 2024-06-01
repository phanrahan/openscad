import nervoussystem.obj.*;
import peasy.*;

String filename="";
PeasyCam cam;
int ALTURA =600;
float ZSCALE = 0.5;

Cadena cad;
float dt = 0.25;
float collisionDist =10;
float dist = 1;
float elast = 1; // valores altos suavizan más la figura (1 como referencia)

int estabiliza = 5; // ciclos para estabilizar los puntos antes de incluir otro

float expansion =5;
PVector centro = new PVector(0, 0, 0);

boolean bugged = false; // activa un interesante 'bug' que saca patrones distintos
float noisezoom = 0.51;

int zDecay = round(ALTURA); // valor de Z para el cual empieza a borrar puntos
int init = floor(ALTURA); // valor inicial de Z para mostrar la figura
boolean centered = true;

float contador = 0;

ArrayList<PVector>[] vertices;
boolean record=false;
boolean rendertopbottom = true;

float radius(float g){
   float rr = 1.75;
   
    float r = 0.5 +0.2*(cos( radians(g*rr ) ));// barrel
   //float r = sin(radians(g*rr));
   
   return r;
}

void setup() {
  size(700, 700, P3D);
  centro = new PVector(0, 0, 0);
  
  cam = new PeasyCam(this, 400);

  // random init
  //randomSeed(1);
  //noiseSeed(2);

  cad = new Cadena();
  cad.init();
  vertices = new ArrayList[ALTURA];
  // Crea el array de Arraylists
  for (int i = 0; i<ALTURA; i++) {
    vertices[i] = new ArrayList<PVector>();
  }


  // estabiliza inicial
  for (int i = 0; i<60; i++) {
    cad.update();
  }

  // genera
  int z = 0;
  do {
    // estabiliza (evita que las lineas se crucen
    for (int i = 0; i<estabiliza; i++) {
      cad.update();
    }



    // Guarda puntos
    for (int i = 0; i<cad.puntos.size(); i++) {
      Punto p = cad.puntos.get(i);
      vertices[z].add(new PVector(p.pos.x, p.pos.y, z*ZSCALE));
    }
    // Añade punto
    contador++;
    if (z<zDecay) {
      cad.addPunto();
    } else {
      cad.deletePunto();
    }
    z++;
  } while (z<ALTURA);
}

void draw() {
  if(frameCount==1){
    surface.setLocation(10,10);
    surface.setVisible(true);
  }
  background(0);
  lights();
  //cad.dibuja();
  //cad.update();

  //if (frameCount>10 && frameCount % 10==0) {
  //  cad.addPunto();

  //}

  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", filename);
  }else{
  //rotateX(PI);
  translate(0, 0, -90);//-ZSCALE*ALTURA/2);
  }
  stroke(100);
  noStroke();
  fill(255);

  for (int z = init; z<ALTURA-1; z++) {
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i<vertices[z].size(); i++) {
      PVector v1 = vertices[z].get(i % vertices[z].size());
      PVector v3 = vertices[z+1].get(i % vertices[z+1].size());
      //point(v.x,v.y,v.z);
      //line(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z);
      
      vertex(v3.x, v3.y, -v3.z);
      vertex(v1.x, v1.y, -v1.z);
    }

    if (vertices[z].size()<vertices[z+1].size()) {
      PVector v1 = vertices[z].get(0);
      PVector v3 = vertices[z+1].get(vertices[z+1].size()-1);
      PVector v4 = vertices[z+1].get(0);
      vertex(v3.x, v3.y, -v3.z);
      vertex(v1.x, v1.y, -v1.z);
      vertex(v4.x, v4.y, -v4.z);
    } else {
      PVector v1 = vertices[z].get(0);
      vertex(v1.x, v1.y, -v1.z);
    }

    endShape();
  }

  // STRIP
  fill(255, 150, 0);
  float m1=0,m2=0;

  
  for (int z=0; z<180; z++) {

    beginShape(QUAD_STRIP);
    for (int i = 0; i<vertices[ALTURA-1].size()+1; i++) {
      PVector v1 = vertices[ALTURA-1].get(i%vertices[ALTURA-1].size());
      float z1 = z;
      float z2 = z+1;
 
      m1 = radius(z);
      m2 = radius(z+1);
      vertex(v1.x*m2, v1.y*m2, z2);
      vertex(v1.x*m1, v1.y*m1, z1);
    }
    endShape();
  }

if(rendertopbottom){
  // CAP BOTTOM

  beginShape();
  for (int i = vertices[ALTURA-1].size()-1; i>=0 ; i--) {
  //for (int i = 0; i<vertices[ALTURA-1].size(); i++) {
    PVector v1 = vertices[ALTURA-1].get(i);
      m1 = radius(0);
      vertex(v1.x*m1, v1.y*m1, 0);
  }
  endShape(CLOSE);


  // CAP TOP

  beginShape();
  int z = 180;

  for (int i = 0; i<vertices[ALTURA-1].size(); i++) {
    PVector v1 = vertices[ALTURA-1].get(i);

    vertex(v1.x*m2, v1.y*m2, z);
  }
  endShape(CLOSE);
}



  if (record) {
    endRecord();
    record = false;
  }
}



void keyPressed()
{
  if (key == 'r') {
    
    selectOutput("Select a file to write to:", "fileSelected");
    surface.setLocation(10,10);
    surface.setVisible(true);
    record = true;
    noLoop();
    
  }
}
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    filename =selection.getAbsolutePath();
  }
  loop();
   
}