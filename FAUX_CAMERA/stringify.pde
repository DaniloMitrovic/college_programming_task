// setting string methods
String str( pnt p ){
  String s = "";
  s += p.name + " |  ";
  s += p.i;
  s += " , " + p.j;
  s += " , " + p.k;
  return s;
}
String str( frame f){
  String ret = " [ ";
  ret += " D {" + f.dims[0] + " , " + f.dims[1]+ "} " ;
  ret += " M {" + f.marg[0] + " , " + f.marg[1]+ "} " ;
  ret += " P {" + f.padd[0] + " , " + f.padd[1]+ "} " ;
  ret += "]";
  return ret;
}
String str( ellipsoid e ){
  String ret = "";
  ret += "(X/"+e.radius.i+")^2";
  ret += " + ";
  ret += "(Y/"+e.radius.j+")^2";
  ret += " + ";
  ret += "(Z/"+e.radius.k+")^2";
  ret += " = 1";
  return ret;
}
String str( plane p){
  String p_name = "";
  String p_pnts = "";
  
  for( int i = 0; i < p.constraint.length ; i++ ){
    p_name += ( p_name == "" ? "" : "-") + p.constraint[i].name;
    p_pnts += "\n\t "+str( p.constraint[i] ).replace("|",":>");
  }
  return "| " + p_name + " | " + p_pnts;
}
String str(b_box b){
  String b_name = "";
  String b_pnts = "";
  for( int i = 0; i < 8 ; i ++ ){
    b_name += b.pnts[i].name;
  }
  for( int i = 0; i < 6 ; i ++ ){
    b_pnts += str( b.plns[i] )+"\n";
  }
  
  return "b: { "+b_name + " }\n" + b_pnts;
}
String str( camera c ){
  String s = "";
  s += " CAM : { ";
  s += str(c.project.radius) + " }";
  s += " "+ str(c.outer);
  s += " "+ str(c.inner);
  return s;
}

// default prints
void print( pnt o ){ print( str(o) ); }
void print( frame o ){ print( str(o) ); }
void print( ellipsoid o ){ print( str(o) ); }
void print( plane o ){ print( str(o) ); }
void print( b_box o ){ print(str(o) ); }
void print( camera o ){ print(str(o) ); }

void println( pnt o ){ println( str(o) ); }
void println( frame o ){ println( str(o) ); }
void println( ellipsoid o ){ println( str(o) ); }
void println( plane o ){ println( str(o) ); }
void println( b_box o ){ println( str(o) ); }
void println( camera o ){ println( str(o) ); }


// list prints
void print( pnt[] o ){
  for( int i = 0; i < o.length ; i ++ ){
    print( o[i] );
  }
}
void println( pnt[] o ){
  for( int i = 0; i < o.length ; i ++ ){
    println( o[i] );
  }
}

void print( frame[] o ){
  for( int i = 0; i < o.length ; i ++ ){
    print( o[i] );
  }
}
void println( frame[] o ){
  for( int i = 0; i < o.length ; i ++ ){
    println( o[i] );
  }
}

void print( ellipsoid[] o ){
  for( int i = 0; i < o.length ; i ++ ){
    print( o[i] );
  }
}
void println( ellipsoid[] o ){
  for( int i = 0; i < o.length ; i ++ ){
    println( o[i] );
  }
}
void print( plane[] o ){
  for( int i = 0; i < o.length ; i ++ ){
    print( o[i] );
  }
}
void println( plane[] o ){
  for( int i = 0; i < o.length ; i ++ ){
    println( o[i] );
  }
}
void print( b_box[] o ){
  for( int i = 0; i < o.length ; i ++ ){
    print( o[i] );
  }
}
void println( b_box[] o ){
  for( int i = 0; i < o.length ; i ++ ){
    println( o[i] );
  }
}
