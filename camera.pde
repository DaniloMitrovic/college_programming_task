class camera {

  frame outer;  // framing plane
  frame inner;  // projection plane
  ellipsoid project; // projection object


  camera() {
    this.outer = new frame(width, height);  // whole screen
    this.outer.asign_padding( 10.0, 10.0 );  // padding fro this.inner
    this.inner = new frame(this.outer);
    this.project = new ellipsoid( new pnt( 24, 27, 27 ) ); // a bit fatty but what the hell [mm]
  }

  void set_focal_length( float fl) {
    this.project.radius.i = fl;
  }
  
  void set_film_dimension( float w, float h ) {
    float diagonal = sqrt( pow(w, 2) + pow(h, 2) );
    diagonal /= 2;

    this.project.radius.j = diagonal;
    this.project.radius.k = diagonal;
  }
  
  float get_frame_step(){
    float w,h;
    w = this.inner.dims[0];
    h = this.inner.dims[1];

    float frame_sqr = 2*this.project.radius.j*this.project.radius.k;
    float root_frame= sqrt( pow( w*this.project.radius.k ,2) + pow( h*this.project.radius.j ,2) );
    return frame_sqr/root_frame;
  }
  
  pnt get_screen(){
    float w,h;
    w = this.inner.dims[0];
    h = this.inner.dims[1];
    pnt ret = new pnt();    
    ret.add_name("frame_projected");
    ret.j = (w/2)*this.get_frame_step();
    ret.k = (h/2)*this.get_frame_step();
    return ret;
    
  }
  
}

void show_on_camera( camera cam_o, plane o, float fl, float scale){
  /*
  STAGES:
  enviorment preparation
    -> asigning new focal point
    -> scaling down the ellipsoid
      IF ELLIPSOID IS TOO BIG THE OBJECT WILL HAVE AN ORTHOGONAL LIKE PROJECTION
      IF ELLISPOID IS TOO SMALL THE OBJECT WILL BE OUTSIDE THE FRAME SINCE ANY PROJECTION TO 0,0,0 WILL BE AT LARGE ANGLE OF LIMITS TO p/2
    -> scaling down the frame of projection onto YZ ellipse 
      This can be done only when ellipsoid is scaled, since:
        
        frame F[ w/2, h/2 ] :> centered aroudn 0,0,0
        t = 2*Ry*Rz/ sqrt( pow(w*Rz,2) + pow(h*Ry,2) );
        frame newF[ w*t*.5, h*t*.5 ]
        
        so if Ry,Rz,Rx isn't scaled down... wrong results will happen
   
   plane preparation:
     -> getting the projection of each point on the plane
     -> removing the x axis :> since we dont actually need it anymore :: AKA projection of that point on YZ plane
   
   BOUNDS:
     -> check if the point is inside the plane of framing
     -> if point is outside of frame bounds
     -> grab i=0, i-1,i+1
       :> function from i-1 -> i=0 find intertion that fits on the plane
       :> function from i=0 -> i+1 find insertion that fits on the plane
         -> populate plane with new found points in right indicies
     
   Rescaling
     -> rescale to the frame size :> [metric]->[pixel]
   
   Represent:
     -> draw a shape
  */
  
  //ENV setup
  cam_o.set_focal_length(fl);                                // devising the Rx coordinate of the ellipsoid
  cam_o.project.radius = cam_o.project.radius.p_div(scale);  // scaling down ellispoid
  pnt new_frame = cam_o.get_screen();                        // scaling down the frame
  
  //plane prepraration
  plane projected_p = new plane();  
  for( int i =0; i < o.constraint.length ; i ++ ){
    pnt temp = new pnt();  // generating placeholder point
    String name = o.constraint[i].name;  // grabbing name from point
    
    temp = o.constraint[i]; // swaping temp values
    temp = cam_o.project.get_projection( temp );  // getting projection
    temp.name = name;  // asigning the name
    temp.i = 0;        // removing the x axis
    projected_p.add_point(temp);  // adds point to the placeholder plane
  }
  
  //bounds
  plane bounds = new plane();  // new plane containing all points inside bounds
  
  // for each point in plane constraint
  for( int i = 0; i < projected_p.constraint.length  ;i ++ ){
    
    if( check_p_against_frame(projected_p.constraint[i], new_frame ) ){ bounds.add_point( projected_p.constraint[i] ); }
    else{  // current point is out of bounds
      int l_i = i == 0 ? projected_p.constraint.length -1: i-1; // if current index is 0 flip the
      pnt last = projected_p.constraint[l_i];
      pnt curr = projected_p.constraint[i];
      
      float[] l_c = slope_interceptXY( last,curr );
      
      if( abs(curr.j) > new_frame.j ){
        pnt tempj = new pnt();
        tempj.name = last.name+curr.name+'j';
        
        tempj.j = new_frame.j;
        tempj.k = new_frame.j*l_c[0]+l_c[1];
        
        if( check_p_against_frame( tempj, new_frame ) ){ bounds.add_point( tempj ); }
      }
      
      if( abs(curr.k) > new_frame.k ){
        pnt temp = new pnt();
        temp.name = last.name+curr.name+'k';
        
        temp.k = new_frame.k;
        temp.j = (new_frame.k - l_c[1] )/l_c[0];
        
        if( check_p_against_frame( temp, new_frame ) ){ bounds.add_point(temp); }        
      }
    }
  }
    
  // rescaling
  float mult = 1/cam_o.get_frame_step();
  for( int i = 0; i < bounds.constraint.length ; i++ ){
    String name = bounds.constraint[i].name;
    bounds.constraint[i] = bounds.constraint[i].p_mult(mult);
    bounds.constraint[i].j *= -1;
    bounds.constraint[i].k *= -1;
    bounds.constraint[i].name = name;
  }
  
  //drawing 
  float[] inn = cam_o.inner.to_draw();
  rect( inn[0], inn[1], inn[2], inn[3] );
  fill(0xff);
  
  translate( width/2, height/2 );

  beginShape();  
  for( int i =0; i <= bounds.constraint.length; i++ ){
    int j = (i+1)%bounds.constraint.length;
    float w,h;
    w = bounds.constraint[j].j;
    h = bounds.constraint[j].k;
    vertex(w,h);
  }
  endShape();
}

void show_on_camera( camera cam_o, pnt o, float fl, float scale ){
  
  /*
  STAGES:
  enviorment preparation
    -> asigning new focal point
    -> scaling down the ellipsoid
      IF ELLIPSOID IS TOO BIG THE OBJECT WILL HAVE AN ORTHOGONAL LIKE PROJECTION
      IF ELLISPOID IS TOO SMALL THE OBJECT WILL BE OUTSIDE THE FRAME SINCE ANY PROJECTION TO 0,0,0 WILL BE AT LARGE ANGLE OF LIMITS TO p/2
    -> scaling down the frame of projection onto YZ ellipse 
      This can be done only when ellipsoid is scaled, since:
        
        frame F[ w/2, h/2 ] :> centered aroudn 0,0,0
        t = 2*Ry*Rz/ sqrt( pow(w*Rz,2) + pow(h*Ry,2) );
        frame newF[ w*t*.5, h*t*.5 ]
        
        so if Ry,Rz,Rx isn't scaled down... wrong results will happen
   
   Point preparation:
     -> getting the projection of point o
     -> removing the x axis :> since we dont actually need it anymore :: AKA projection of that point on YZ plane
   
   BOUNDS:
     -> check if the point is inside the plane
     -> calculate the diameter of circle to that point can be visible if misake is made :: aproxx
     -> manipulate the object so it fits
     
   Rescaling
     -> rescale to the frame size :> [metric]->[pixel]
   
   Represent:
     -> draw a point
  */
  
  //ENV setup
  cam_o.set_focal_length(fl);                                // devising the Rx coordinate of the ellipsoid
  cam_o.project.radius = cam_o.project.radius.p_div(scale);  // scaling down ellispoid
  pnt new_frame = cam_o.get_screen();                        // scaling down the frame
  
  //PNT setup
  o = cam_o.project.get_projection(o);
  o.i = 0;
  float r = 1/scale;
  
  
  //bounds
  if( ( o.j > new_frame.j ) || (o.k >= new_frame.k ) ){
    float e_d = sqrt( pow(o.j,2) + pow(o.k,2) );
    r /= e_d;
  }
  
  //rescaling back
  float mult = 1/cam_o.get_frame_step();
  o = o.p_mult(mult);
  o.j *= -1;
  o.k *= -1;
  
  //representation
  float[] inn = cam_o.inner.to_draw();
  
  rect( inn[0], inn[1], inn[2], inn[3] );
  fill(0xff);
  
  translate( width/2, height/2 );
  ellipse( o.j, o.k , r, r );
   
}
