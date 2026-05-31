$fn=36;

module fillet(r) {
   offset(r = -r) {
     offset(r = r) {
       children();
     }
   }
}

module cross (){
    union() {
        square([40,10], center=true);
        square([10,40], center=true);
     }
 }
 
 fillet(-2) 
     fillet(2)
         cross();