/*
   basic utilities.. default values that made this programm possible. 
   
   UNIT is an default scale for the whole project. Since one is in mm ( camera ellipsoid ) and other is in PIXEL ( the screen ) i needed some sort of scaling and reference
   even if 1 unit is 1
  
   derive_fl       :> derivation fo focal length. I wanted to be able to change the representation of cube...so focal length of camera is changable via mouse wheel
   derive_movement :> in first this was suposed to be a rotation matrix... but ... it isn't since rotation was buggy as hell... so i switched up to location
   set_location    :> changes the location of the cube. So the perspective trick is shown. Also... this was suposed to apply rotation to the box... still buggy.
*/

float focal_length = 24;
pnt click_move = new pnt();
int click_count = 0;

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
  click_move.i += ( x >= 0 ) ? 1 : -1 ;  // stores the sign of x in i
  click_move.j += ( y >= 0 ) ? 1 : -1 ;  // stores the sign of y in j
  click_move.k += sqrt( pow(x,2) + pow(y,2) ); // step of x,y in k
  click_count++;
}

void change_loc(){
  click_move = click_move.p_div( float(click_count) );
  
  click_move.k *= (click_move.i < 0 ? -1 : 1) * (click_move.j < 0 ? -1 : 1 );
  
  click_move.i = abs(click_move.i);
  click_move.j = abs(click_move.j);
  
  int i,j;
  i = int( click_move.i*2)%3;
  j = int( click_move.j*2)%3;
  
  click_move.i = float(i)/2;
  click_move.j = float(j)/2;
  click_move.k /= UNIT;
  
  if( ( click_move.i != 0 ) && (click_move.j != 0 ) ){
    if( click_move.i == click_move.j ){ box_loc = box_loc.add( new pnt( 0,0, click_move.k ) );}
    else{
      if( click_move.i > click_move.j ){ box_loc = box_loc.add( new pnt(click_move.k , 0, 0) ); }
      else{ box_loc = box_loc.add( new pnt( 0, click_move.k, 0 ) );}
    }
  }  
  click_move = new pnt();
  click_count = 0;
}
