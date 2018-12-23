class brep{
  ln[] boundary = {};
  
  brep(){} // defaults not not asigned face
  
  brep( ln[] o ){
    this.boundary = o;
  }
  
  boolean hasPoint( pnt o ){
    boolean found = false;
    for( int i = 0; i < this.boundary.length ; i ++ ){
      
      if( this.boundary[i].isStart(o) || this.boundary[i].isEnd(o) || this.boundary[i].hasPoint(o) ){
        found = true;
        break;
      }
    }
    return found;
  }
  
  boolean hasLine( ln o){
    boolean found = false;
    for( int i = 0; i < this.boundary.length ;i++ ){
      if( this.boundary[i].equal(o) ){
        found = true;
        break;
      }
    }
    return found;
  }  
  
  void update( pnt []o ){
    for( int oi =0; oi < o.length ; oi ++ ){
      for( int l = 0; l < this.boundary.length ; l++ ){       
        if( this.boundary[l].isStart(o[oi]) ){
          this.boundary[l].switchStart( o[oi] );
        }
        if( this.boundary[l].isEnd( o[oi] ) ){
          this.boundary[l].switchEnd( o[oi] );
        }
      }
    }
  }
  
  void update( ln o ){
    for( int l = 0; l < this.boundary.length ; l ++ ){
      if( this.boundary[l].name == o.name ){
        this.boundary[l] = o;
      }
    }
  }
  
  void update(ln[] o) {
    for( int i = 0; i < o.length; i++ ){
      this.update( o[i] );
    }
  }
}

String str(brep o ){
  String name = "";
  String info = "";
  
  for( int i =0; i < o.boundary.length ;i++){
    name += o.boundary[i].start.name;
    info += "\n\t" + str( o.boundary[i] );
  }
  return " [FACE] : "+name+" :\n" + info;
}
