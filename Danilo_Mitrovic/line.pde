class ln{
  
  pnt start,end;
  String name = "ln";
  pnt slope, intercept;
  
  ln(){
    this.start = new pnt();
    this.end   = new pnt(1,1,1);
    this.gen_line();
  }
  
  ln( pnt a, pnt b){
    this.start = a;
    this.end   = b;
    if( ( a.name != "pnt" ) && ( b.name != "pnt" ) ){
      this.name = a.name + b.name;
    }
    this.gen_line();
  }
  
  void gen_line(){
    float sXY,sYZ,sXZ;
    float iXY,iYZ,iXZ;
    
    sXY = ( this.end.j - this.start.j )/( this.end.i - this.start.j );
    sYZ = ( this.end.k - this.start.k )/( this.end.j - this.start.j );
    sXZ = ( this.end.k - this.start.k )/( this.end.i - this.start.i );
    this.slope = new pnt( sXY, sYZ, sXZ );
    
    iXY = this.start.j - this.start.i*sXY;
    iYZ = this.start.k - this.start.j*sYZ;
    iXZ = this.start.k - this.start.i*sXZ;
    this.intercept = new pnt( iXY,iYZ,iXZ );    
  }
  
  float x_from_y( float y ){ return (y-this.intercept.i)/this.slope.i; }
  float y_from_x( float x ){ return this.slope.i*x + this.intercept.i; }
  float y_from_z( float z ){ return (z-this.intercept.j)/this.slope.j; }
  float z_from_y( float y ){ return this.slope.j*y + this.intercept.j; }
  float x_from_z( float z ){ return (z-this.intercept.k)/this.slope.k; }
  float z_from_x( float x ){ return this.slope.k*x + this.intercept.k; }
  
  pnt pnt_from_x( float x){
    return new pnt( x,this.y_from_x( x),this.z_from_x( x));
  }
  pnt pnt_from_y( float y){ 
    return new pnt( this.x_from_y(y), y, this.z_from_y(y));
  }
  pnt pnt_from_z( float z){
    return new pnt( this.x_from_z(z), this.y_from_z(z), z );
  }
  
  boolean isEnd( pnt o ){
    return ( this.end.name.equals(o.name)   || this.end.equal(o) );
  }
  boolean isStart( pnt o){
    return ( this.start.name.equals(o.name) || this.start.equal(o) );
  }
  
  boolean hasPoint( pnt o ){
    pnt o1 = this.pnt_from_x( o.i );
    return o1.equal(o);
  }
  
  void switchEnd( pnt o ){
    if( o.name == "pnt" ){
      o.name = this.end.name;
    }
    if(( this.start.name != "pnt" ) && ( this.end.name != "pnt" ) ){
      this.name = this.start.name + this.end.name;
    }
    this.end = o;
    this.gen_line();
  }
  void switchStart( pnt o ){
    if( o.name == "pnt" ){
      o.name = this.start.name;
    }
    if(( this.start.name != "pnt" ) && ( this.end.name != "pnt" ) ){
      this.name = this.start.name + this.end.name;
    }
    this.start = o;
    this.gen_line();
  }
  
  float length( ){
    pnt l = this.end.sub(this.start);
    return l.origin_vect();
  }
  
  boolean equal( ln o ){
    return this.start.equal(o.start) && this.end.equal(o.end);
  }
  boolean not_equal( ln o ){
    return this.start.not_equal(o.start) && this.end.not_equal(o.end );
  }
  
}

String str( ln o ){
  String ret = "";
  ret += "- "+o.name+" - ";
  ret += "[ "+ str(o.start) + " , " + str(o.end) + " ]";
  return ret;  
}
