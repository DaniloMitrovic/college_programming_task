
void setup(){
  size(0,0);
  noLoop();
  
  float[] r= {1,2,3};
  float[] p = {2.1,4.8,0};
  
  float[] pi = find_intersection( r, p );
  println( isInEllipsoid( r, pi ) );
  
  //println( isInEllipsoid( r, p ) );
  
}

void draw(){exit();}

float[] find_intersection( float[] r, float[] p ){
  float[] ret = {0,0,0};
  float t = ( r[0]*r[1]*r[2] )/ sqrt( pow( p[0]*r[1]*r[2],2) + pow( p[1]*r[0]*r[2] ,2) + pow(p[2]*r[0]*r[1],2) );
  ret[0] = p[0]*t;
  ret[1] = p[1]*t;
  ret[2] = p[2]*t;
  return ret;

}
boolean isInEllipsoid( float[] r , float[] p ){
  
  float x, y, z;
  x = pow( p[0]/r[0],2 );
  y = pow( p[1]/r[1],2 );
  z = pow( p[2]/r[2],2 );
  
  println(p);
  println();
  println(r);
  println("-------");
  println( " -> " + x );
  println( " -> " + y );
  println( " -> " + z );
  println( x + y + z );
  println("-------");
  
  return (int)(x + y + z) == 1.0;
  
}
