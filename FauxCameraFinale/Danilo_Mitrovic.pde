camera cammy;
b_box boxy;
pnt   box_loc;

void setup(){
  size(1024,768);
  set_unit(METRI);
  cammy = new camera();
  box_loc = new pnt(4,0,0 );
  
}

void draw(){
  boxy = new b_box();
  change_loc();
  boxy.asign_location(box_loc);
  
  cammy.set_focal_length( focal_length );
  translate( width/2, height/2);
  
  cammy.draw_window();
  cammy.show(boxy);
  
}

void mouseWheel( MouseEvent event ){ derive_fl(event); }
void mouseDragged(){ derive_movement(); }
