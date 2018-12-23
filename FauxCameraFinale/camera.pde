class camera{
  ellipsoid projector;
  frame window;
  
  camera(){
    this.window = new frame(width,height,15,15);
    this.projector = new ellipsoid();
  }
  void set_focal_length( float fl ){
    this.projector.radius.i = fl/UNIT;
  }
  void set_film_dimension( float filmw, float filmh ){
    this.projector = new ellipsoid( this.projector.radius.i , filmw, filmh );
  }
  
  void draw_window(){
    float[] t = this.window.tr_draw();
    stroke(0xA0);
    strokeWeight(1);
    background(0xAF);
    rect( t[0], t[1], t[2], t[3] );
    fill(0xff);
  }
  
  pnt prepare( pnt o ){
    pnt t = new pnt();
    float k = this.projector.get_step( o );
    t = o.p_mult( k );
    t.name = o.name;
    t.i = 0;
    t.j *= -1;
    t.k *= -1;
    return t;
  }
  ln prepare( ln o ){
    return new ln( this.prepare(o.start), this.prepare(o.end ) );
  }
  brep prepare( brep o){
    ln[] b = new ln[0];
    for( int i = 0; i < o.boundary.length ;i++ ){
      b = (ln[])append( b, this.prepare( o.boundary[i] ) );
    }
    return new brep( b );
  }
  b_box prepare( b_box o ){
    pnt[] ps = new pnt[0];
    b_box ret = new b_box( o.dims.i, o.dims.j, o.dims.k );
    for( int i =0; i < o.pnts.length ; i++ ){
      ps = (pnt[])append( ps, this.prepare( o.pnts[i] ) );
    }
    ret.pnts = ps;
    ret.update();
    return ret;
  }
  
  pnt get_frame( ){
    float t = this.projector.get_step_YZ( this.window.display.w*.5, this.window.display.h*.5 );
    pnt ret = new pnt();
    ret.name = "frame";
    ret.j = this.window.display.w*t;
    ret.k = this.window.display.h*t;
    return ret;
  }
  
  pnt rescale( pnt o ){
    float t = this.projector.get_step_YZ( this.window.display.w*.5 ,this.window.display.h*.5 );
    pnt ret = new pnt(o);
    ret = o.p_div(t);
    ret.name = o.name;
    return ret;
  }
  ln rescale( ln o ){
    return new ln( this.rescale(o.start), this.rescale(o.end) );
  }
  brep rescale( brep o ){
    ln[] ret = new ln[0];
    for( int i =0; i < o.boundary.length ; i++ ){
      ret = (ln[])append( ret, this.rescale( o.boundary[i] ) );
    }
    return new brep( ret );
  }
  b_box rescale( b_box o ){
    pnt[] temp = new pnt[0];
    b_box ret = new b_box( o.dims.i, o.dims.j, o.dims.k );
    for( int i =0; i < o.pnts.length; i++ ){
      temp = (pnt[])append( temp, this.rescale( o.pnts[i] ) );
    }
    ret.pnts = temp;
    ret.update();
    return ret;
  }
  
  void draw( pnt o ){
    stroke(0);
    point(o.j,o.k);
  }
  void draw( ln o ){
    stroke(0);
    strokeWeight(1);
    line( o.start.j, o.start.k, o.end.j, o.end.k );
  }
  void draw( brep o ){
      PShape face = createShape();
      face.setStroke( color(0) );
      face.setFill( color(255,255,255,0) );
      face.beginShape();
      face.strokeWeight(1);
      for( int i = 0; i < o.boundary.length ; i++ ){
        face.vertex( o.boundary[i].start.j, o.boundary[i].start.k );
      }
      face.endShape(CLOSE);
      shape(face);
  }
  void draw( b_box o ){
    for( int i =0; i < o.breps.length; i++ ){
      this.draw( o.breps[i] );
    }
  }
  
  void show( b_box o ){
    this.draw( this.rescale( this.prepare( o ) ) );
  }
  
}
