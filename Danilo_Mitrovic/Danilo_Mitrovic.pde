camera cammy;
b_box boxy;
pnt   box_loc;

/*
  Author : Danilo Mitrovic Au 124/2014
  
  Camera is centrated over i [x] direction by longer axis of an ellipsoid
  Mouse pressed and drag to move j,k location of the box  [y,z]
  Press Z,X keys to move i location of the box  [x]
  
  Autor: Danilo Mitrovic AU 124/2014
  
  Kamera je centrirana preko i [x] pravca duzeg radijusa elipsoida
  Pritisnuti levi taster misa i drzati da bi se kocka pomerila u i,j pravcu [ y,z ]
  Pritisnuti Z,X tastere da se kocka pomeri u i pravcu [x] 
  
  4c30f8bafb2281515165c8d7e75d2291
*/

void setup(){
  size(1024,768);
  set_unit(METRI);
  cammy = new camera();
  box_loc = new pnt(4,0,0 );
  
}

void draw(){
  boxy = new b_box();
  boxy.asign_location(box_loc);
  
  cammy.set_focal_length( focal_length );
  translate( width/2, height/2);
  
  cammy.draw_window();
  cammy.show(boxy);
  
}

void mouseWheel( MouseEvent event ){ derive_fl(event);  }
void mouseDragged()                { derive_movement(); }
void keyPressed()                  { change_depth();    } //Z,X
