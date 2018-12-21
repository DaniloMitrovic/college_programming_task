class frame{
  
  float[] dims = new float[2]; // width , height
  float[] marg = new float[2];  // margins
  float[] padd = new float[2];  // padding
  
  frame( float w, float h ){
    this.dims[0] = w;
    this.dims[1] = h; 
    this.asign_margin(  0.0 , 0.0 );
    this.asign_padding( 0.0 , 0.0 );
  }
  
  frame( frame f ){
    this.dims[0] = f.dims[0];
    this.dims[1] = f.dims[1];
    this.asign_margin( f.padd[0], f.padd[1] );
    this.asign_padding( 0.0,0.0 );
  }
  
  void asign_margin( float w, float h ){
    this.marg[0] = w;
    this.marg[1] = h;
    this.update();
  }
  
  void asign_padding( float w, float h ){
    this.padd[0] = w;
    this.padd[1] = h;
  }
  
  void update(){
    this.dims[0] -= 2*this.marg[0];
    this.dims[1] -= 2*this.marg[1];
  }
  
  void draw(){
    rect( this.marg[0],this.marg[1], this.dims[0], this.dims[1] );
  
  }
  
  float[] to_draw(){
    float[] ret = new float[4];
    ret[0] = this.marg[0];
    ret[1] = this.marg[1];
    ret[2] = this.dims[0];
    ret[3] = this.dims[1];
    return ret;
  }
  
}
