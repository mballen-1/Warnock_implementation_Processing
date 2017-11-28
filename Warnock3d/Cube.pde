class Cube{
  
  Plane front, back, left, right, up, bottom;
  
  Cube(Plane p1, Plane p2, Plane p3, Plane p4, Plane p5, Plane p6){
   this.front = p1;
   this.back = p2;
   this.left = p3;
   this.right = p4;
   this.up = p5;
   this.bottom = p6;
  }

}