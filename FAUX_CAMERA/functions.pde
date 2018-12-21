float eucl_distance( pnt o ){
  int i = 1;
  i *= o.i < 0 ? -1 : 1;
  i *= o.j < 0 ? -1 : 1;
  i *= o.k < 0 ? -1 : 1;
  return i*sqrt( pow(o.i,2) + pow(o.j,2) + pow(o.k,2) );
}

float[] slope_interceptXY( pnt a, pnt b){
  
  float Ax,Ay;
  Ax = a.j;
  Ay = a.k;
  float Bx,By;
  Bx = b.j;
  By = b.k;
  
  float slope = (By-Ay)/(Bx-Ax);
  float intercept = Ay - Ax*slope;
  
  float[] ret = new float[2];
  ret[0] = slope;
  ret[1] = intercept;
  
  return ret;
}

boolean check_p_against_frame( pnt o, pnt frame){
  
  float idif,jdif,kdif;
  idif = frame.i-abs(o.i);
  jdif = frame.j-abs(o.j);
  kdif = frame.k-abs(o.k);
  return !( (idif<0) && (jdif<0) && (kdif<0) );  
}

boolean inList( int item, int[] list ){
  boolean found = false;
  for( int i = 0; i < list.length; i++ ){
    if( item == list[i]){
      found = true;
      break;
    }
  }
  return found;
}

int getIndex( int item, int[] list ){
  int ret = 0;
  for( int i = 0; i < list.length ; i++ ){
    if ( list[i] == item ){
      ret = i;
      break;
    }
  }
  return ret;
}

pnt[] bubble( pnt[] arr ){
  int i = 1;
  while( i < arr.length ){
    int j = i;
    
    float Aj = eucl_distance( arr[j] );
    float Aj1= eucl_distance( arr[j-1] );
    
    while ( ( j > 0 ) && ( Aj1 > Aj ) ){
      pnt temp = arr[j];
      arr[j] = arr[j-1];
      arr[j-1] = temp;
      j -= 1;
    }
    i += 1;
  }
  return arr;
}
