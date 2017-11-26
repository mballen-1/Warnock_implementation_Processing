PImage img;
int lim = 7;
int current = 0;

void setup(){
  size(450,600);
  noSmooth();
  //img = loadImage("data\\1.jpg");
}

void draw(){
   //background(0);
   if (current==0){
     background(205); 
   }
   
   
    
     float r = random(255);
     float g = random(255);     
     float b = random(255);
       
     beginShape(TRIANGLES);
       fill(r, g, b);
       stroke(r, g, b);
       vertex(random(width), random(height));
       vertex(random(width), random(height));
       vertex(random(width), random(height));
     endShape();
   
   
   
   revisar(0,width,0,height, current);
}

void keyPressed() {
  if (key == ' ')
    current = current < lim ? current+1 : 0;
}

void revisar (int x1, int x2, int y1, int y2, int lim){
     
     int c = 0;
     boolean aux = true;
              
     //img.loadPixels();
     System.out.println("x1 " + x1);
     System.out.println("x2 " + x2);
     
     loadPixels();
     for (int x = x1; x < x2; ++x){
      for (int y = y1; y < y2; ++y){
        
        int loc = x + y * width;
        
        float r = red(pixels[loc]);
        float g = green(pixels[loc]);
        float b = blue(pixels[loc]);
        
        if (color(r,g,b) != -1){
          if (c != color(r,g,b)){
            if (c != 0){
              aux = false;          // No all in the square are from the same color (split it in 4 parts)
            }
            else{
              c = color(r,g,b);
            }
          }
        }
      }
   }
   
   if (aux || lim ==0){
     pintar (x1,x2,y1,y2);
   }
   else if (lim>0){
     
     int x3 = (x2-x1) /2 + x1 ;
     int y3 = (y2-y1) /2 + y1;
     
     revisar (x1, x3, y1, y3, lim-1); 
     revisar (x3, x2, y1, y3, lim-1); 
     revisar (x1, x3, y3, y2, lim-1);
     revisar (x3, x2, y3, y2, lim-1);
   
 }
}

void pintar(int x1,int x2,int y1,int y2){
   
   loadPixels();
   //img.loadPixels();
   
   for (int x = x1 ; x < x2 ; ++x){
      for (int y = y1; y < y2 ; ++y){
        
        int loc = x + y * width;
        int loc2 = x + y * width;
        float r = red(pixels[loc]);
        float g = green(pixels[loc]);
        float b = blue(pixels[loc]);
        //System.out.println("r,g,b : "+ r +" " +g + " "+b);
         if (color(r,g,b) != -1){
          pixels[loc2] = color(r,g,b);
        }
      }
   }
   
   updatePixels();
   stroke (200,200,0);
   line (x1,y1, x1, y2);
   line (x2,y1, x2, y2);
   line (x1, y1, x2, y1);
   line (x1, y2, x2, y2);
}