camera cam1;
b_box boxy;
pnt loc;

void setup(){
  size( 800 , 450 );
  background(128);
  
  
  
  
  //cam1 = new camera(16);
  boxy = new b_box(5.5,5.5,5.5);
  //loc = new pnt(3,3,3);
  //cam1.show( boxy , loc ); // sta god
  
  pnt[] bp = boxy.gen_pnts();
  println(bp);
  println();
  
  for( int i = 0; i < bp.length ; i ++ ){
     loc = bp[i];
     bp[i] = bp[ ((i*3)%2)%bp.length ];
     bp[ ((i*3)%2)%bp.length ] = loc;
  }
  
  println(bp);
  println();
  
  bp = sort(bp);
  
  println(bp);
  println();
  
  
}

//void draw(){}

void mouseDragged( MouseEvent event ){
  println( pmouseX-mouseX );
  println( pmouseY-mouseY );
  println();
}

void mouseWheel( MouseEvent event ){
  float e = event.getCount();
  if ( e < 0 ){
    println(" rotated from user");
  }
  if(e>0){
    println(" rotated towards user");
  }
  println();
}

// functions
