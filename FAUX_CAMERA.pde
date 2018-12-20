// pcs data declaration
float focal_length;
float angle_inc;   // angle increment
int click_count;   // keeping count of movement acces
float[] rotation = new float[3];// rotation array
float scale = 1000; // metric

// custom data declaration
pnt click_move;    // storing the movement
pnt box_loc;
b_box boxy;
camera cammy;


void setup(){
  size( 800, 450 );
  background(0x7f);
  
  //pcs data inits
  focal_length = 150;
  angle_inc = PI/18;
  click_count = 0;
  
  //custom data inits
  click_move = new pnt();
  box_loc    = new pnt(12,2,2);
  boxy = new b_box();
  cammy = new camera();
  
  boxy.asign_location(box_loc);
  //setting the camera
  String name = cammy.project.radius.name;
  cammy.project.radius = cammy.project.radius.p_div(scale);
  cammy.project.radius.name = name;
}

void draw(){
    
  gen_rotations(); // generating rotation array  
  // implementing rotations
  for( int i = 0; i < rotation.length ; i ++ ){
    boxy.box_rotate( rotation[i], i );
  }
  
  cammy.set_focal_length( focal_length/scale );
  cammy.inner.draw();
  translate(width/2,height/2);
  
  println( boxy );
  println( prepare( boxy , cammy.project ) );
  println( rescale(prepare( boxy , cammy.project ), cammy) );
  println();
  
  //show_on_camera(cammy, box_loc, focal_length, 1000 );
  //show_on_camera( cammy , boxy.plns[3] , focal_length , 1000.0 );
  rotation = new float[3];
}

void mouseWheel(MouseEvent event){
  float e = event.getCount();
  focal_length += ( e >= 0) ? 5 : -5;
}

void mouseDragged(){
  float x_pos = 0, y_pos = 0;
  x_pos = ( pmouseX-mouseX);
  y_pos = ( pmouseY-mouseY);
  click_move.i += ( x_pos >= 0 ) ? 1 : -1 ;  // stores the sign of x in i
  click_move.j += ( y_pos >= 0 ) ? 1 : -1 ;  // stores the sign of y in j
  click_move.k += sqrt( pow(x_pos,2) + pow(y_pos,2) ); // step of x,y in k
  click_count++;
}

void gen_rotations(){
  click_move = click_move.p_div( click_count);  // average versions
  
  click_move.k *= ( click_move.i < 0 ) ? -1 : 1;
  click_move.k *= ( click_move.j < 0 ) ? -1 : 1;
  
  click_move.i = abs(click_move.i);  // {0.0->1.0}
  click_move.j = abs(click_move.j);  // {0.0->1.0}
  
  // so far i overall x direction
  // so far j overall y direction
  // and now k is stepping element
  int x,y;
  x = (int)(click_move.i*2);
  y = (int)(click_move.j*2);
  x = x%3;
  y = y%3;
  
  click_move.i = (float)x;
  click_move.j = (float)y;
  click_move.i /= 2;
  click_move.j /= 2;
  
  if( ( click_move.i != 0 ) && ( click_move.j != 0) ){
    if( click_move.i == click_move.j ){  // diagonal movement => rotation y axis
      rotation[1] = click_move.k*angle_inc;
    }else{
      if( click_move.i > click_move.j){
        rotation[2] = click_move.k*angle_inc;
      }else{
        rotation[0] = click_move.k*angle_inc;
      }
    }
  }
  
  click_move = new pnt();
  click_count = 0;
}
