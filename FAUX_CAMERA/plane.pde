class plane{
  
  /*
  Since face is an collection of lines and points. Now i could theoretically make a new object called line ( which i may have to )
  but face is defined by bounded surface, where bounds are lines drawn between points.
  You can define a plane by 2 lines, a line and a point outside the line, 3 points etc
  but ... this is face. Plane was taken ... i hope so ... else it is a poor word chooice on my part. 
  */
  
  pnt[] constraint = {};
  
  plane(){}  // defaults to not asigned plane
  
  plane( pnt[] o){
    
    this.constraint = (pnt[])expand( this.constraint, o.length );  // for nth point plane  // hardly useed
    
    for( int i =0; i < o.length ; i ++ ){
       this.constraint[i] = o[i];
    }
  }
  
  boolean hasPoint( pnt o ){  // since processing doesn't have normal map, filter functionailty i had to invent a containing function -.-
    
    if( this.constraint.length == 0 ){ return false; } // if the constraint is empty there are no points to compare to
    boolean found = false;  // base bool
    for( int i = 0; i < this.constraint.length; i++ ){  // for each point
      if(this.constraint[i].name == o.name ){ // if name is the same as point name 
        found = true;  // found it!
        break;        // break loop
      }
    }
    return found;
  }
  
  void add_point( pnt o ){ // adds a point to the plane
    if( this.hasPoint(o) == false ){  // since there are no adresses of objects... it is necesery to loop over every reference 
      this.constraint = (pnt[])expand( this.constraint, this.constraint.length+1 ); // expands the current constraint by a point
      this.constraint[ this.constraint.length-1 ] = o;                              // adds the point at the length-1 ( since every bloody loop doesnt go to the length )
    }
  }
  
  int length(){ return this.constraint.length ; } // well duh
  
  void update( pnt o ){
    if( this.hasPoint(o) == true ){
      for( int i = 0 ; i < this.constraint.length; i ++ ){
        if( this.constraint[i].name == o.name ){
          this.constraint[i] = o;
        }
      }
    }
  }
  
  //point ARRAY MUST BE NAMED
  void bulk_update( pnt[] o){  // bulk updating... maybe i could make an individual point update... naaaaah
    
    for( int i = 0; i < o.length ; i++ ){
      this.update( o[i] );
    }
    
  }
}
