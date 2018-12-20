class b_box{
  boolean flipped;
  pnt dims;
  pnt[] pnts = new pnt[0];
  plane[] plns = new plane[0];
  
  b_box(){ // defaults to the box of 1,1,1
    this.dims = new pnt(1,1,1);
    this.gen_data();
    this.flipped = false;
  }
  
  b_box( float w, float h, float d){ // setting floating values
    this.dims = new pnt( w,h,d );
    this.gen_data();
    this.flipped = false;
  }
  
  b_box( int w, int h, int d){
    this.dims = new pnt( (float)w,(float)h,(float)d ); // setting integer values
    this.gen_data();
    this.flipped = false;
  }
  
  void asign_location( pnt l ){
    for( int i = 0; i < this.pnts.length ; i++ ){
      String name = this.pnts[i].name;
      this.pnts[i] = this.pnts[i].p_add(l);
      this.pnts[i].name = name;
    }
    this.gen_planes();
  }
  
  void box_rotate( float angle, int axis ){ // rotating box for an angle
    
    if( this.hasData() == false ){ // if it hasn't got planes and points generated
       this.gen_data();  // generate them
    }
    
    for( int i = 0; i< this.pnts.length ;i ++ ){  // for each point
      if( axis == 0 ){ // axis = i, remains j,k  // if rotation is over x axis, the movement is based upon y,z axis
        pnts[i].j = pnts[i].j*cos(angle) - pnts[i].k*sin(angle);
        pnts[i].k = pnts[i].j*sin(angle) + pnts[i].k*cos(angle);
      }
      if( axis == 1 ){ // axis = j, remains i,k // if rotation is over y axis, the movement is based upon x,z axis
        pnts[i].i = pnts[i].i*cos(angle) - pnts[i].k*sin(angle);
        pnts[i].k = pnts[i].i*sin(angle) + pnts[i].k*cos(angle);
      }
      if( axis == 2 ){ // axis = k, remains i,j  // if rotation is over z axis, the movement is based upon x,y axis
        pnts[i].i = pnts[i].i*cos(angle) - pnts[i].j*sin(angle);
        pnts[i].j = pnts[i].i*sin(angle) + pnts[i].j*cos(angle);
      }
    }
    this.update(); // update box planes
  }
  
  boolean hasData(){ // checks if box has any data to work with [ planes, points ]
    return ( (this.pnts.length!=0) && (this.plns.length!=0) ); 
  }
  
  boolean hasPoints(){
    return (this.pnts.length!=0);
  }
  
  boolean hasPlanes(){
    return (this.plns.length!=0);
  }
  
  void gen_data(){
    this.gen_pnts();
    this.gen_planes();
  }
  
  void gen_pnts(){ // generate points
    
    this.pnts = (pnt[])expand(this.pnts, 8 );  // expand points by 8 ... since cube has 8 corners
    
    for( int i = 0; i < this.pnts.length ; i++ ){  // for each point
       
        pnt temp = new pnt(); // make a new default point,0,0,0
        
        // a bit of binary magic
        temp.i = ( ( i & 1) == 1 ) ? this.dims.i : 0;  
        temp.j = ( ( i & 2) == 2 ) ? this.dims.j : 0;
        temp.k = ( ( i & 4) == 4 ) ? this.dims.k : 0;
        
        /*
          to be able to succesfully rotate it without  worrying about 0 coordinates, i will remove the half of dimensions from each point
          in that way center of an box is in real center of the box, not coordinate 0,0,0
          
          may be unecesary 
        */
        temp = temp.p_sub(  this.dims.p_div(2)  );
        temp.add_name( char(65+i) );  // adds a name, char(65) == A, so 66 = B etc
        this.pnts[i] = temp;  // asigns the point
    }
    
  }
  
  void gen_planes(){  // generate planes
    
    if( this.hasPoints() == false ) { this.gen_pnts(); }
    
    this.plns = (plane[])expand(this.plns, 6);  // extend the planes by 6, E = V + F - 2
    for( int i = 0; i < this.plns.length ; i ++ ){
      this.plns[i] = new plane();
    }
    int plane_id = 0;  // plane id place holder
    
    for( int i = 0; i < this.pnts.length ; i ++ ){  // for each point
      for( int n = 0; n < 3 ; n ++ ){  // for each axis
        
        // a bit of binary magic
        plane_id =( ( i&(1<<n) )==( 1<<n ) ) ? 1 : 0;
        plane_id += 5 - (1<<n) - (int)(n/2) - (n%2); // succes :D awesomeeeee
        this.plns[plane_id].add_point(this.pnts[i]); // asigns a point to a plane
        
      }
      
    }
    
    for( int i =0; i < this.plns.length ; i++ ){
      this.plns[i].constraint = bubble(this.plns[i].constraint);
    }
    
  }
  
  void update(){  // updates a box
    for( int i = 0; i < this.plns.length; i ++ ){  // for each point in a points
      this.plns[i].bulk_update( this.pnts );  // bulk updates a plane
    }
  }
}
