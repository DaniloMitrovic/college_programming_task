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
  
  float[] to_draw(){
    float[] ret= new float[4];
    ret[0] = this.offset.w;
    ret[1] = this.offset.h;
    ret[2] = this.display.w - this.offset.w*2;
    ret[3] = this.display.h - this.offset.h*2;
    return ret;
  }
  
  float[] tr_draw(){
    float[] ret  = new float[4];
    ret[0] = -( this.display.w-offset.w*2 )*.5;
    ret[1] = -( this.display.h-offset.h*2 )*.5;
    ret[2] = this.display.w-offset.w*2;
    ret[3] = this.display.h-offset.h*2;
    return ret;
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
