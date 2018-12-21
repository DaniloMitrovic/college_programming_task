pnt prepare( pnt o, ellipsoid projector){
  pnt ret = new pnt();
  String name = o.name;
  ret = projector.get_projection(o);
  ret.i *= 0;
  ret.j *= -1;
  ret.k *= -1;
  ret.name = name;
  return ret;
}

pnt rescale( pnt o, camera c ){
  pnt ret = new pnt();
  float mult = 1.0/c.get_frame_step();
  ret.i = o.i*mult;
  ret.j = o.j*mult;
  ret.k = o.k*mult;
  ret.name = o.name;
  return ret;
}

pnt[] prepare( pnt[] o, ellipsoid projector ){
  pnt[] ret = new pnt[o.length];
  for( int i = 0; i < o.length; i++ ){
    ret[i] = prepare( o[i], projector );
  }
  return ret;
}
pnt[] rescale( pnt[] o, camera c ){
  pnt[] ret = new pnt[o.length];
  for(int i =0; i < o.length; i++ ){
    ret[i] = rescale( o[i], c );
  }
  return ret;
}

plane bounds( plane o , camera c ){
  plane ret = new plane();
  
  pnt frame = c.get_screen();
  
  for( int i =0; i < o.constraint.length ;i ++ ){
    
    if( !check_p_against_frame( o.constraint[i], frame ) ){
      
      int curr, last;
      curr = i;
      last = ( i == 0 ? o.constraint.length : i ) -1;
      
      float[] l_c = slope_interceptXY( o.constraint[last], o.constraint[curr] );
      float slope = l_c[0];
      float intcpt= l_c[1];
      
      /*
        find jdiff, kdiff and make points accordingly.
        
      */
      
      
    }
    
  }
  return ret;
}

//----------------
plane prepare( plane o, ellipsoid projector ){
  plane ret = new plane();
  ret.constraint = prepare( o.constraint,projector  );
  return ret;  
}

plane rescale( plane o, camera c ){
  plane ret = new plane();
  ret.constraint = rescale( o.constraint, c );
  return ret;
}

b_box prepare( b_box o, ellipsoid projector ){
  b_box ret = new b_box();
  ret.pnts = prepare( o.pnts, projector );
  ret.gen_planes();
  return ret;
}
b_box rescale( b_box o, camera c){
  b_box ret = new b_box();
  ret.pnts = rescale( o.pnts, c );
  ret.gen_planes();
  return ret;
}
