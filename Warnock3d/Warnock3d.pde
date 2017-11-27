/**
 * Warnock algorithm with standard camera.
 * by Miguel Angel Ballen, Camilo Neiva, Jean Pierre Charalambos.
 * 
 * A 'standard' Camera with fixed near and far planes.
 * 
 * Note that the precision of the z-Buffer highly depends on how the zNear()
 * and zFar() values are fitted to your scene (as it is done with the default PROSCENE
 * camera). Loose boundaries will result in imprecision along the viewing direction.
 * 
 * Press 't' in the main viewer (the upper one) to toggle the camera kind.
 * Press 'h' to display the key shortcuts and mouse bindings in the console.
 */
import processing.core.*;
import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;

Scene scene, auxScene1, auxScene2;
PGraphics canvas, auxCanvas1, auxCanvas2;

StdCamera stdCam;
Camera origCam;
float angle = 0;

boolean stop = false;             // When to stop the scene and the random function
int triangleAmount = 3;

ArrayList<Integer> random_values;
ArrayList<Integer> random_colors;

int w = 1280;
int h = 760;
Point screenPoint = new Point();
Vec orig = new Vec();
Vec dir = new Vec();
Vec end = new Vec();

Vec pup;


void settings() {
  size(w, h, P3D); 
  
  random_values = new ArrayList<Integer>();
  random_colors = new ArrayList<Integer>();
  
  for (int i = 0; i< triangleAmount*900; ++i){
     random_values.add((int)random(-100, 100));  // Set random values for triangles vertex
     random_colors.add((int)random(0, 255));
  }
}


void setup() {
   
  canvas = createGraphics(w, h/2, P3D);
  scene = new Scene(this, canvas);

  scene.eyeFrame().removeMotionBinding(CENTER);
  scene.eyeFrame().setClickBinding(LEFT, 1, "zoomOnPixel");
  scene.eyeFrame().setClickBinding(CENTER, 1, "anchorFromPixel");

  stdCam = new StdCamera(scene);
  scene.setCamera(stdCam);
  scene.setRadius(250);
  scene.camera().setUpVector(new Vec(1300, 1300,-1300), true);
  scene.showAll();

  // enable computation of the frustum planes equations (disabled by default)
  scene.enableBoundaryEquations();
  scene.setGridVisualHint(true);

  auxCanvas1 = createGraphics(w/2, h/2, P3D);
  // Note that we pass the upper left corner coordinates where the scene
  // is to be drawn (see drawing code below) to its constructor.
  auxScene1 = new Scene(this, auxCanvas1, 0, h/2);
  auxScene1.camera().setType(Camera.Type.ORTHOGRAPHIC);
  auxScene1.camera().setUpVector(new Vec(0, 0, -255), true);
  auxScene1.setAxesVisualHint(true);
  auxScene1.setGridVisualHint(true);
  auxScene1.setRadius(150);
  auxScene1.showAll();
  
  auxCanvas2 = createGraphics(w/2, h/2, P3D);
  // Note that we pass the upper left corner coordinates where the scene
  // is to be drawn (see drawing code below) to its constructor.
  auxScene2 = new Scene(this, auxCanvas2, w/2, h/2);
  auxScene2.setCamera(stdCam);
  auxScene2.camera().setType(Camera.Type.ORTHOGRAPHIC);
  auxScene1.camera().setUpVector(new Vec(0, 0, 0), true);  
  auxScene2.setAxesVisualHint(true);
  auxScene2.setGridVisualHint(true);
  auxScene2.setRadius(150);
  auxScene2.showAll();
 
  noLoop();
}

void mainDrawing(Scene s) {
  
  PGraphics p = s.pg();
  p.background(0);
  p.noStroke();
  // the main viewer camera is used to cull the sphere object against its frustum
  switch (scene.ballVisibility(new Vec(0, 0, 0), scene.radius()*0.6f)) {
  case VISIBLE:
    
      
    for(int i=0 ; i< triangleAmount; i++){
      p.fill(random_colors.get(i*10),random_colors.get(i+1*10), random_colors.get(i*12));   //Define color
      p.stroke(255);
      p.rotateX(PI/2);
      p.rotateZ(-PI/6);

      p.beginShape();
        p.vertex(random_values.get(0), random_values.get(1), random_values.get(2));
        p.vertex( random_values.get(3), random_values.get(4), random_values.get(5));
        p.vertex(   random_values.get(6), random_values.get(7),  random_values.get(8));
      p.endShape();
    }
    break;
  
  
  case SEMIVISIBLE:
    for(int i=0 ; i< triangleAmount; i++){
      p.fill(random_colors.get(i*10),random_colors.get(i+1*10), random_colors.get(i*12));   //Define color
      p.stroke(255);
      p.rotateX(PI/2);
      p.rotateZ(-PI/6);
      
      p.beginShape();
        p.vertex(random_values.get(0), random_values.get(1), random_values.get(2));
        p.vertex( random_values.get(3), random_values.get(4), random_values.get(5));
        p.vertex(   random_values.get(6),    random_values.get(7),  random_values.get(8));
      p.endShape();
    }
    break;
  case INVISIBLE:
    break;
  }
}

void auxiliarDrawing(Scene s) {
  mainDrawing(s);    
  s.pg().pushStyle();
  s.pg().stroke(255, 255, 0);
  s.pg().fill(255, 255, 0, 160);
  s.drawEye(scene.camera());
  s.pg().popStyle();
}

void draw() {
  
  //rotateY(angle); 
  surface.setTitle("Warnock algorithm demostration ");
  scene.beginDraw();
  
  mainDrawing(scene);
  scene.endDraw();
  scene.display();

  auxScene1.beginDraw();
  auxiliarDrawing(auxScene1);
  auxScene1.endDraw();
  auxScene1.display();
  
  auxScene2.beginDraw();
  auxiliarDrawing(auxScene2);
  auxScene2.endDraw();
  auxScene2.display();
  angle += 0.01;
  
}

void keyPressed() {
  if (key == 't') {
    stdCam.toggleMode();
    this.redraw();
  }
  if ( key == 'u' )
    scene.eyeFrame().setMotionBinding(MouseAgent.WHEEL_ID, "translateZ");
  if ( key == 'v' )
    scene.eyeFrame().setMotionBinding(MouseAgent.WHEEL_ID, "scale");
  if(key == 's' || key == 'S')
    stop = !stop;
    if (stop == false) {
      noLoop();
    }
    if (stop == true) {
    loop();
    }
    if (key == 'r' || key == 'R') {
      
    }
    
    
    
}

public class StdCamera extends Camera {
  
  boolean standard;

  public StdCamera(Scene scn) {
    super(scn);
    // camera frame is a gFrame by default, but we want an iFrame
    // to bind 'u' and 'v' actions to it
    setFrame(new InteractiveFrame(this));
    standard = false;
  }

  public void toggleMode() {
    standard = !standard;
  }

  public boolean isStandard() {
    return standard;
  }

  @Override
  public float zNear() { 
    if (standard) 
      return 0.001f; 
    else 
      return super.zNear();
  }

  @Override
  public float zFar() {
    if (standard) 
      return 1000.0f; 
    else 
      return super.zFar();
  }

  @Override
  public float rescalingOrthoFactor() {
    if (isStandard())
      return 1.0f;
    return super.rescalingOrthoFactor();
  }
}


void mouseClicked() {
  if (mouseButton == RIGHT) {
    pup = scene.pointUnderPixel(new Point(mouseX, mouseY));
    System.out.println("pup: " + pup);
    if ( pup != null ) {
      screenPoint.set(mouseX, mouseY);
      scene.camera().convertClickToLine(screenPoint, orig, dir);        
      end = Vec.add(orig, Vec.multiply(dir, 1000.0f));
    }
  }
}