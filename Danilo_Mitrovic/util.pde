/*
   basic utilities.. default values that made this programm possible. 
   
   UNIT is an default scale for the whole project. Since one is in mm ( camera ellipsoid ) and other is in PIXEL ( the screen ) i needed some sort of scaling and reference
   even if 1 unit is 1
  
   derive_fl       :> derivation fo focal length. I wanted to be able to change the representation of cube...so focal length of camera is changable via mouse wheel
   derive_movement :> in first this was suposed to be a rotation matrix... but ... it isn't since rotation was buggy as hell... so i switched up to location
   set_location    :> changes the location of the cube. So the perspective trick is shown. Also... this was suposed to apply rotation to the box... still buggy.
*/

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

void derive_fl( MouseEvent event ){
  float e = event.getCount();
  focal_length += (e>0) ? 5 : -5;
  if( focal_length < 24 ){ focal_length = 24; }
}

void derive_movement( ){
  float x,y;
  x = (pmouseX-mouseX);
  y = (pmouseY-mouseY);
  box_loc.k += (.5*y)/UNIT;
  box_loc.j += (.5*x)/UNIT;
}

void change_depth(){
  if( keyPressed){
    if( keyCode == 90 ){  // Z button
      box_loc.i += 90/UNIT;
    }
    if( keyCode == 88 ){  //X button
      box_loc.i -= 90/UNIT;
    }
  }
}
