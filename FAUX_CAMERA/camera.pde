class camera{
  
  int bg = 0xEF;
  float[] projection = new float[2];
  float[] px_mm     = new float[2];
  float ratio = 0; 
  float focal_length = 0;
  
  camera( float fl ){
    this.projection[0] = width;
    this.projection[1] = height;
    this.ratio = width/height;
    
    this.px_mm[0] = ( this.is_landscape() ? width/32 : height/32 );
    this.px_mm[1] = this.px_mm[0]*this.ratio;
    this.focal_length = fl;
    
  }
  
  boolean is_landscape(){ return this.projection[0]>this.projection[1]; }
  
  float manipulate( float p_dim, float distance ){
    return ( p_dim/(2*distance) )*this.focal_length;
  }
  
  void show( b_box b, pnt at ){
    //frame maintainance
    translate( width/2, height/2);
    background(this.bg);
    rect( -(width/2)+15, -(height/2)+15, width-30, height-30);
    
    //fill( 0x1f*sun_coeficient) sun is allays from left side;
    // rect( xorigin, yorigin, width, height )
    
    pnt[] box_points = b.gen_pnts();
        
    for( int i = 0 ; i < box_points.length ;i++){
      box_points[i] = box_points[i].p_add(at);
    }
    box_points = sort( box_points);
    
    pnt minimum = box_points[0];
    
    /*
      NEED TO FIGURE OUT HOW::
        -> ROTATE AN BOX... something based upon sin,cos but how to implement it 3d not planary only
        -> ROTATE BY AN X,Y and Z;
        -> REPRESENT IT AS ROTATED
      
      INTERESTING RULE:
        IF box is oriented towards the camera, a whole face will be visible so the amout of the points closest to camera is 4, so what i need is 4 points to define it
        IF box is oriented at an angle towards the camera , an edge will be visible and have same x,y or z coordinate , so what i need is 2 points for edge and 6 others to be able to draw it
        IF box is rotated in a bunch of ways, only 1 point will be closes7 to the camera , so i will need 7 points to be able to draw it
      
        in short, if i have n points, 8-n points is necesery to draw the full shape.
        
        !! find a way to represent a 3 coordinate systyem points to 2d shape !! px_mm has 2 dimensions only, your points have 3.!!
        
        !!ADVISED ACTION!!
        TO EVERY POINT ADD AN DISTANCE FROM CAMERA
        AFTER THAT FIND THE POINT WITH MINIMUM VALUE
        IF THERE ARE OTHER POINTS WITH SAME VALUE FOR X,Y or Z FROM MINIMUM POINT
        GO INTO "SWITCH" STATEMENT
        
        IF THERE IS ONLY 1 MINIMUM VALUE POINT
          : REMOVE FORM LIST THE MAXIMUM VALUE POINT  
              -- HAD [8] , GOT [7]
            ->GENERATE A SHAPE FROM THAT
        IF THERE ARE 2 POINTS WITH SAME VALUE FOR X,Y or Z OF MINIMUM POINT // ASUME THAT IT IS AN EDGE
          : FIND AN EXACT PAIRING FROM THOSE TWO POINTS, AND REMOVE FURTHEST EDGE 
              -- HAD [8] , GOT [6]
            -> GENERATE SHAPE FROM THAT
        IF THERE ARE MORE THAN 2 POINTS WITH SAME VALUE FOR X,Y or Z AXIS OF MINIMM POINT // ASUME THAT IT IS A FACE
          : FIND 4 POINTS WITH SAME 2 AXIES AS MINIMUM POINT THAT ARE CLOSES TO CAMERA
            -> GENERATE SHAPE FROM THAT.
      
      
      
      AFTER SHAPES ARE GENERATED, COLLOR THEM BY VALUE SCHEME
      
      FIND A WAY TO MANIPULATE A BOX ( ROTATION, ZOOM ... ETC ) WITH AN MOUSE EVENTS
      
    
    */
    
    //println(box_points);
    
  }
  
}
