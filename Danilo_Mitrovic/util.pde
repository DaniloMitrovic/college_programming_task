/*
   basic utilities.. default values that made this programm possible. 
   
   UNIT is an default scale for the whole project. Since one is in mm ( camera ellipsoid ) and other is in PIXEL ( the screen ) i needed some sort of scaling and reference
   even if 1 unit is 1
  
   derive_fl       :> derivation fo focal length. I wanted to be able to change the representation of cube...so focal length of camera is changable via mouse wheel
   derive_movement :> in first this was suposed to be a rotation matrix... but ... it isn't since rotation was buggy as hell... so i switched up to location
   set_location    :> changes the location of the cube. So the perspective trick is shown. Also... this was suposed to apply rotation to the box... still buggy.
*/
boolean dims = false;
float[] box_temps = new float[3];
float box_w=1.0,box_h=1.0,box_d=1.0;

float focal_length = 24;
float UNIT;
float METRI      = 100.0;
float CENTIMETRI = 10.0;
float MILIMETRI  = 1.0;
float INCHI      = 25.4;
float STOPE      = 304.8;

void set_unit( float u ){
  UNIT = u;
}

void mouseClicked( MouseEvent event ){
  if(dims){
    if( mouseButton == LEFT){ box_temps[0] += 1; }
    if( mouseButton == RIGHT){box_temps[1] += 1; }
    if( mouseButton == 3 )  { box_temps[2] += 1; }
  }
}
void keyPressed(){
  
  if( key == ENTER) { dims = !dims; }
  if( !dims ){
    box_w = ( box_temps[0] != 0 ? box_temps[0] : box_w );  // left click
    box_h = ( box_temps[1] != 0 ? box_temps[1] : box_h );  // right click
    box_d = ( box_temps[2] != 0 ? box_temps[2] : box_d );  //middle key
    box_temps = new float[3];
  }
  
}

void mouseWheel( MouseEvent event ){
  if( !mousePressed ){
    float e = event.getCount();
    focal_length += (e<0 ? 5 : -5 );
    if( focal_length < 24 ){ focal_length = 24; }
    if( focal_length > 1000 ) { focal_length = 1000; }
  } else {
    if( mouseButton == LEFT ){
      float e = event.getCount();
      box_loc.i += (e>0 ? 1 : -1 )*50/UNIT;
    }
  }
}

void mouseDragged( MouseEvent event ){
    if( ( mouseButton == LEFT ) && cammy.window.isOver(event) ) {
      float x,y;
      x = (pmouseX-mouseX);
      y = (pmouseY-mouseY);
      box_loc.k += (.5*y)/UNIT;
      box_loc.j += (.5*x)/UNIT;
    }
}
