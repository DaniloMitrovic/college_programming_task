class ellipsoid{
  pnt radius;
    
  ellipsoid( pnt o ){
    this.radius  = o;
  }
  
  boolean hasPoint( pnt o ){
    float eps = 1.0/pow(10,6);
    float ell_ = pow( o.i/this.radius.i ,2) + pow( o.j/this.radius.j ,2) + pow( o.k/this.radius.k ,2) ; // ellipsoid equation == 1.0
    float result = ( ell_ >= 1 ) ? ell_ - 1 : 1 - ell_;
    return result < eps;
  }
  
  //it doesn't work
  pnt get_projection( pnt o ){ // should return projected point that is on line 0A and on ellispoid
    /*
      perspective should work as projection of an form onto ellispoid
      the focal length, and dimension of film should be ellispoid radiuses 
      
      so projection of point A onto ellispoid E, 
      point of porjection A' should have A'x,A'y,A'z coordinates that lie on ellispoid
      
      formed by vector that connects middle of ellipsoid ( 0,0,0 ) to the point A(Ax,Ay,Az)
      
      vector of an line (x-xo)/(x1-xo) = (y-yo)/(y1-yo) = (z-zo)/(z1-zo) = I
      from start+index*step = new value, for O(0,0,0) and A the index is 1 and step is A(x,y,z)
      there fore with above linear 3d formula we can get the new step that is within ellipsoid.
      
      If ellispsoid main axis Radius is orianted on X axis and every other point will be oriented on positive X quadrant, we need only X positive values
      
      in short::>
        T = Rx*Ry*Rz / sqrt( (Ax*Ry*Rz)^2 + (Ay*Rx*Rz)^2 + (Az*Ry*Rx)^2  ) -> this gives me the I on ellispoid , or Ia/EllispoidI
        quadrants :> Ax*Ry*Rz, Ay*Rx*Rz,Az*Ry*Rx
        
      
    */
      float[] quadrant = { o.i*this.radius.j*this.radius.k , o.j*this.radius.i*this.radius.k , o.k*this.radius.i*this.radius.j  };
      quadrant[0] = pow( quadrant[0],2);
      quadrant[1] = pow( quadrant[1],2);
      quadrant[2] = pow( quadrant[2],2);
      
      float t = ( this.radius.i*this.radius.j*this.radius.k)/sqrt( quadrant[0] + quadrant[1] + quadrant[2] ); // in generall this is positive and in 0 < t < 1
      
      pnt ret = new pnt();
      ret.i = o.i*t;
      ret.j = o.j*t;
      ret.k = o.k*t;
      
    return ret;
  }
  
}
