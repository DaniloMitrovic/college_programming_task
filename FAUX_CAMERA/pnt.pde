class pnt{
  float i,j,k;
  int ortho_dir;
  
  pnt(){
    this.i = 0;
    this.j = 0;
    this.k = 0;
  }
  
  pnt( float x, float y, float z ){
    this.i = x;
    this.j = y;
    this.k = z;
  }
    
  boolean equal( pnt o ){
    return ( (this.i==o.i) && (this.j==o.j) && (this.k==o.k) );
  }
  
  boolean not_equal( pnt o ){
    return ( (this.i!=o.i) || (this.j!=o.j) || (this.k!=o.k) );
  }
  
  boolean larger( pnt o ){
    if( this.not_equal(o) ){
      int mask = 0;
      if( (this.i < o.i) || (this.i==o.i) ){ mask^=1; }
      if( (this.j < o.j) || (this.j==o.j) ){ mask^=2; }
      if( (this.k < o.k) || (this.k==o.k) ){ mask^=4; }
      return mask == 0;
    }
    return false;
  }
  
  
  boolean larger_equal( pnt o ){
    if( this.not_equal(o) ){
      int mask = 0;
      if(this.i < o.i){ mask^=1; }
      if(this.j < o.j){ mask^=2; }
      if(this.k < o.k){ mask^=4; }
      return mask == 0;
    }
    return false;
  }
  
  boolean less( pnt o ){
    if( this.not_equal(o) ){
      int mask = 0;
      if( (this.i > o.i) || (this.i==o.i) ){ mask^=1; }
      if( (this.j > o.j) || (this.j==o.j) ){ mask^=2; }
      if( (this.k > o.k) || (this.k==o.k) ){ mask^=4; }
      return mask == 0;
    }
    return false;
  }
  
  boolean less_equal( pnt o ){
    if( this.not_equal(o) ){
      int mask = 0;
      if(this.i > o.i){ mask^=1; }
      if(this.j > o.j){ mask^=2; }
      if(this.k > o.k){ mask^=4; }
      return mask == 0;
    }
    return false;
  }
  
  pnt p_add( pnt o ){
    pnt ret = new pnt();
    ret.i = this.i + o.i;
    ret.j = this.j + o.j;
    ret.k = this.k + o.k;
    return ret;
  }
  
  pnt p_sub( pnt o){
    pnt ret = new pnt();
    ret.i = this.i - o.i;
    ret.j = this.j - o.j;
    ret.k = this.k - o.k;
    return ret;
  }
  
  pnt p_div( float o ){
    pnt ret = new pnt();
    ret.i = this.i / o;
    ret.j = this.j / o;
    ret.k = this.k / o;
    return ret;
  }
  
}

void print( pnt p){
  print( " i: " + p.i + " , j: " + p.j + " , k: " + p.k );
}

void println( pnt p ){
  print( " i: " + p.i + " , j: " + p.j + " , k: " + p.k + '\n' );
}

void println( pnt[] p ){
  for(int i=0; i< p.length ; i++ ){
    println( p[i] );
  }
}

pnt[] sort( pnt[] o ){
  int i = 0;
  
  while( i < o.length ){
    int j = i;
    while( (j>0 ) && ( o[j-1].larger(o[j]) ) ){
      pnt temp = new pnt();
      temp = o[j-1];
      o[j-1] = o[j];
      o[j] = temp;      
    }
    i = i + 1;
  }
  return o;
}
