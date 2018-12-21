class pnt{
  float i,j,k; // unit vectors
  String name = ""; // point name ... since processing doesn't have object.id value ... -.-
  
  pnt( pnt o ){
    this.i = o.i;
    this.j = o.j;
    this.k = o.k;
    this.name = o.name;
  }
  
  pnt(){  // defaults to 0,0,0,pnt
    this.i = 0;
    this.j = 0;
    this.k = 0;
    this.name = "pnt";
  }
    
  pnt( float x, float y, float z ){  // float asigment
    this.i = x;
    this.j = y;
    this.k = z;
    this.name = "pnt";
  }
  
  pnt( int x, int y, int z ){  // integer asigment
    this.i = x;
    this.j = y;
    this.k = z;
    this.name = "pnt";
  }
  
  void add_name( String name){  // adds a name to the point
    this.name = name;
  }
  void add_name( char name){    // ads a char name to the point
    String s_name = "";
    s_name += name;
    this.name = s_name;
  }
  
  boolean p_equal( pnt o ){    // equality comparison... the rest of comparisons are too time consuming -> rely on euclidian norm
    return ((this.i == o.i) && (this.j == o.j) && (this.k == o.k ));
  }
  
  boolean p_not_equal( pnt o ){      // not equality comparison... the rest of comparisons are too time consuming -> rely on euclidian norm
    return ((this.i != o.i) && (this.j != o.j) && (this.k != o.k ));
  }
  pnt p_add( pnt o ){  // adds two points
    pnt ret = new pnt();
    ret.i = this.i + o.i;
    ret.j = this.j + o.j;
    ret.k = this.k + o.k;
    return ret;
  }
  
  pnt p_sub( pnt o){  // subtracts two points
    pnt ret = new pnt();
    ret.i = this.i - o.i;
    ret.j = this.j - o.j;
    ret.k = this.k - o.k;
    return ret;
  }
  
  pnt p_div( float o ){  // division by float
    pnt ret = new pnt();
    ret.i = this.i / o;
    ret.j = this.j / o;
    ret.k = this.k / o;
    return ret;
  }
  
  pnt p_mult( float o ){  // multiplying by float
    pnt ret = new pnt();
    ret.i = this.i * o;
    ret.j = this.j * o;
    ret.k = this.k * o;
    return ret;
  }
  
}
