class frame{
  proto_rect display;
  proto_rect offset;
  
  frame() {
    this.display = new proto_rect(width,height);
    this.offset  = new proto_rect(15,15);
  }
  frame( float w, float h, float mw, float mh ){
    this.display = new proto_rect(w,h);
    this.offset  = new proto_rect(mw,mh);    
  }  
  float[] tr_draw(){
    float[] ret  = new float[4];
    ret[0] = -( this.display.w-this.offset.w*2 )*.5;
    ret[1] = -( this.display.h-this.offset.h*2 )*.5;
    ret[2] = this.display.w-this.offset.w*2;
    ret[3] = this.display.h-this.offset.h*2;
    return ret;
  }
  
  boolean isOver(MouseEvent event){
    
    int x,y;
    x = event.getX();
    y = event.getY();
    
    if( x <0 || y < 0){return false;}
    if( x>width || y > height ){return false;}
    
    int isOver = 0;    
    
    if ( x > this.offset.w && x < (this.display.w - this.offset.w ) ){
      isOver += 1;
    }
    if( y > this.offset.h && y < ( this.display.h - this.offset.h ) ){
      isOver += 2;
    }
    return isOver == 3;
  }
  
}

String str(frame o ){
  String ret = "[FRAME] ::> ";
  ret+= str(o.display).replace("PR","DIM");
  ret+= str(o.offset ).replace("PR","M");
  return ret;  
}

class proto_rect{
  float w,h;
  
  proto_rect(){
    this.w = width;
    this.h = height;
  }
  proto_rect( float w, float h ){
    this.w = w;
    this.h = h;
  }
  proto_rect( int w, int h ){
    this.w = float(w);
    this.h = float(h);
  }  
}

String str( proto_rect o){
  String ret = "PR :|: ";
  ret += o.w + " : " + o.h;
  return ret;
}
