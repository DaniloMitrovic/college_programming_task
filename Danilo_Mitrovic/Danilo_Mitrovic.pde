camera cammy;
b_box boxy;
pnt   box_loc;
slider s1;

/*
  Author : Danilo Mitrovic Au 124/2014
  
  Camera is centrated over i [x] direction by longer axis of an ellipsoid
  Mouse pressed and drag to move j,k location of the box  [y,z]
  Press Z,X keys to move i location of the box  [x]
  
  Autor: Danilo Mitrovic AU 124/2014
  
  Kamera je centrirana preko i [x] pravca duzeg radijusa elipsoida
  Pritisnuti levi taster misa i drzati da bi se kocka pomerila u i,j pravcu [ y,z ]
  Pritisnuti   Z,X tastere da se kocka pomeri u i pravcu [x] 
  
  4c30f8bafb2281515165c8d7e75d2291
  
  LBM + drag : controls the position of the box in y,z axis : or in plane infornt of you x,y
  LBM + wheel: controls the distance of the box from your point of view
  
  Wheel : controls the focal point
  
  ENTER + LMBx2 + Wheelx3 + RMBx5 + ENTER gives you box of 2x3x5
  
*/

void setup(){
  size(800,600,P2D);
  set_unit(METRI);
  
  cammy = new camera();
  box_loc = new pnt(4,0,0 );
 
}
//box_w=1.0,box_h=1.0,box_d=1.0
void draw(){
  boxy = new b_box(box_d,box_w,box_h);
  boxy.asign_location(box_loc);
  
  cammy.set_focal_length( focal_length );
  translate( width/2, height/2+10);
  
  cammy.draw_window();
  cammy.show(boxy);
  
}
