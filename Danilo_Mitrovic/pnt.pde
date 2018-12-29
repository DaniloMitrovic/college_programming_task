class pnt{
  float i,j,k;
  String name;
  
  pnt(){
    this.i = this.j = this.k = 0.0;
    this.name = "pnt";
  }
  
  pnt(float x, float y, float z ){
    this.i = x;
    this.j = y;
    this.k = z;
    this.name = "pnt";    
  }
  
  pnt( int x, int y, int z ){
    this.i = (float)x;
    this.j = (float)y;
    this.k = (float)z;
    this.name = "pnt";
  }
  
  pnt( float[] o ){
    if( o.length < 3 ){
      o = (float[]) expand ( o, 3-o.length );
      o[2] = 0;
    }
    this.i = o[0];
    this.j = o[1];
    this.k = o[2];
    this.name = "pnt";
  }
  
  pnt( pnt o ){ // shallow copy
    this.i = o.i;
    this.j = o.j;
    this.k = o.k;
    this.name = o.name;
  }
  boolean equal( pnt o ){
    return( (this.i == o.i ) && ( this.j == o.j ) && ( this.k == o.k )  );
  }
  boolean not_equal( pnt o ){
    return( (this.i != o.i ) && ( this.j != o.j ) && ( this.k != o.k )  );
  }
  
  pnt add( pnt o ){
    pnt ret = new pnt(o);
    ret.i += this.i;
    ret.j += this.j;
    ret.k += this.k;
    ret.name = "pnt";
    return ret;
  }
  
  pnt sub( pnt o ){
    pnt ret = new pnt();
    ret.i = this.i-o.i;
    ret.j = this.j-o.j;
    ret.k = this.k-o.k;
    ret.name = "pnt";
    return ret;
  }
  
  pnt p_div( float o ){
    pnt ret = new pnt();
    ret.name = this.name;
    ret.i = this.i/o;
    ret.j = this.j/o;
    ret.k = this.k/o;
    return ret;
  }
  
  pnt p_mult( float o ){
    pnt ret = new pnt();
    ret.name = this.name;
    ret.i = this.i*o;
    ret.j = this.j*o;
    ret.k = this.k*o;
    return ret;
  }
  
  float origin_vect( ){
    int i = 1;
    i *= ( this.i < 0 ? -1 : 1 );
    i *= ( this.j < 0 ? -1 : 1 );
    i *= ( this.j < 0 ? -1 : 1 );
    return i*sqrt( pow(this.i,2) + pow(this.j,2) + pow(this.k,2) );
  }
}

String str( pnt o ){
  String ret = "";
  ret += o.name + " | ";
  ret += o.i + " , ";
  ret += o.j + " , ";
  ret += o.k;
  return ret;
}
