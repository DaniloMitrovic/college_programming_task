class b_box{
  pnt dims;
  pnt[] pnts = {};
  brep[] breps = {};
  
  b_box(){
    this.dims = new pnt(1,1,1);
    this.gen_data();
  }
  
  b_box( float w, float h , float d ){
    this.dims = new pnt(w,h,d);
    this.gen_data();
  }
  
  b_box( int w, int h, int d){
    this.dims = new pnt(w,h,d);
    this.gen_data();
  }
  
  void asign_location( pnt loc){
    for( int i = 0; i < this.pnts.length ; i++ ){
      String name = this.pnts[i].name;
      this.pnts[i] = this.pnts[i].add(loc);
      this.pnts[i].name = name;
    }
    this.update();
  }
  
  boolean hasPoints(){
    return this.pnts.length!=0;
  }
  void gen_points(){
    if( this.pnts.length == 0 ){ this.pnts = ( pnt[] ) expand( this.pnts, 8 ); }
    
    for( int i =0; i < 8; i++ ){
      pnt temp = new pnt();  
      temp.i = (i&1)==1 ? this.dims.i: 0;
      temp.j = (i&2)==2 ? this.dims.j: 0;
      temp.k = (i&4)==4 ? this.dims.k: 0;
      temp = temp.sub( this.dims.p_div(2) ); // centering the box
      temp.name = str(char(65+i));
      this.pnts[i] = temp;      
    }    
  }
  
  boolean hasBreps(){
    return this.breps.length != 0;
  }
  
  void gen_breps(){
    
    //collection shift
    int[][] brep_points = new int[6][0];
    
    for( int i =0; i < 8 ; i++ ){
      for( int n = 0; n < 3; n ++ ){
        int bp_id = int( ( i&(1<<n) ) == (1<<n) );
        bp_id += 5 - (1<<n) - int(n/2) - (n%2);
        brep_points[bp_id] = append( brep_points[bp_id], i );// storing point index at brep point list
      }}
    
    // i need circular asigment for the lines to avoid the interceting lines.
    for( int i = 0; i<6; i++ ){
      int pid = brep_points[i][3];
      brep_points[i][3] = brep_points[i][2];
      brep_points[i][2] = pid;      
    }
    
    if( !this.hasPoints() ){ this.gen_points(); }
    
    ln[][]  brep_lines  = new ln[6][4];
    
    for( int b = 0; b < 6 ; b++ ){
      for( int l =0 ; l < 4; l ++ ){
        int pl1 = brep_points[b][l];
        int pl2 = brep_points[b][ (l+1)%4 ];
        
        pnt st = this.pnts[pl1];
        pnt ed = this.pnts[pl2];
        
        ln cur = new ln( st, ed );
        brep_lines[b][l] = cur;
      }}
    
    for( int i =0 ; i < 6 ; i++ ){
      brep b = new brep( brep_lines[i] );
      this.breps = (brep[])append( this.breps, b );
    }}
    
    void gen_data(){
      this.gen_points();
      this.gen_breps();
    }
    
    void update(){
      for( int i =0; i < 6; i++ ){ this.breps[i].update( this.pnts ); }
    }
        
}

String str(b_box o){
  String ret = "b: { ";
  for( int i = 0 ; i < o.pnts.length; i++ ){
    ret += o.pnts[i].name;
  }
  ret+= " }";
  return ret;
}
