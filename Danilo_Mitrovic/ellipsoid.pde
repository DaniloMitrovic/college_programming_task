class ellipsoid{
  
  pnt radius;
  
  ellipsoid( ){
    this.radius = new pnt(24/UNIT,27/UNIT,27/UNIT);
  }
  
  ellipsoid( pnt o ){
    this.radius = o;
  }
  
  ellipsoid( float fl, float fw, float fh ){
    float r = sqrt( pow(fw,2) + pow(fh,2) )*.5;
    this.radius = new pnt( fl/UNIT, r/UNIT, r/UNIT );
  }  
  boolean hasPoint( pnt o ){
    float eps = 1/pow(1000,2);
    float X,Y,Z;
    X = pow( o.i/this.radius.i ,2 );
    Y = pow( o.j/this.radius.j ,2 );
    Z = pow( o.k/this.radius.k ,2 );
    float R = X + Y + Z;
    R = ( R < 1 )? 1-R: R-1;
    return R <= eps;
  }
  boolean hasPoint( pnt o, String PLANE ){
    if(( PLANE=="XY") || (PLANE=="YX") ){
      return this.hasValueXY( o.i, o.j );
    }
    if(( PLANE=="YZ") || (PLANE=="ZY") ){
      return this.hasValueYZ( o.j, o.k );
    }
    if(( PLANE=="XZ") || (PLANE=="ZX") ){
      return this.hasValueXZ( o.i, o.k );
    }
    return false;
  }
  boolean hasValueXY( float x, float y){
    float eps = 1/pow(1000,2);
    float X,Y;
    X = pow( x/this.radius.i ,2 );
    Y = pow( y/this.radius.j ,2 );
    float R = X+Y;
    R = (R<1) ? 1-R : R-1;
    return R < eps;
  }
  boolean hasValueYZ( float y, float z){
    float eps = 1/pow(1000,2);
    float Z,Y;
    Z = pow( z/this.radius.k ,2 );
    Y = pow( y/this.radius.j ,2 );
    float R = Z+Y;
    R = (R<1) ? 1-R : R-1;
    return R < eps;
  }
  boolean hasValueXZ( float x, float z){
    float eps = 1/pow(1000,2);
    float Z,X;
    Z = pow( z/this.radius.k ,2 );
    X = pow( x/this.radius.i ,2 );
    float R = Z+X;
    R = (R<1) ? 1-R : R-1;
    return R < eps;
  }
  
  float get_step( pnt o ){
    float E3,OxE,OyE,OzE;
    E3 = this.radius.i*this.radius.j*this.radius.k;
    OxE = o.i*this.radius.j*this.radius.k;
    OyE = o.j*this.radius.i*this.radius.k;
    OzE = o.k*this.radius.i*this.radius.j;
    return E3/sqrt( pow(OxE,2) + pow(OyE,2) + pow(OzE,2) );
  }
  float get_step( float w, float h, float d){
    pnt temp = new pnt(w,h,d);
    return this.get_step(temp);
  }
  float get_step_XY( float x, float y){
    float E2,OxE,OyE;
    E2 = this.radius.i*this.radius.j;
    OxE = this.radius.j*x;
    OyE = this.radius.i*y;
    return E2/sqrt( pow(OxE,2) + pow(OyE,2) );
  }
  float get_step_YZ( float y, float z){
    float E2,OyE,OzE;
    E2 = this.radius.j*this.radius.k;
    OyE= this.radius.k*y;
    OzE= this.radius.j*z;
    return E2/sqrt( pow( OyE ,2) + pow( OzE ,2) );
  }
  float get_step_XZ( float x, float z){
    float E2,OxE,OzE;
    E2 = this.radius.i*this.radius.k;
    OxE= this.radius.k*x;
    OzE= this.radius.i*z;
    return E2/sqrt( pow( OxE ,2) + pow( OzE ,2) );
  }
  float get_step( float a, float b, String TYPE){
    if( (TYPE=="XY") || (TYPE=="YX") ){ return this.get_step_XY(a,b); }
    if( (TYPE=="YZ") || (TYPE=="ZY") ){ return this.get_step_YZ(a,b); }
    if( (TYPE=="XZ") || (TYPE=="ZX") ){ return this.get_step_XZ(a,b); }
    return 0;
  }
}
