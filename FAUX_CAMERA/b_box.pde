class b_box{
  
  pnt dims;
  pnt loc;
  
  b_box( float w, float h, float d){
    this.dims = new pnt( w,h,d );
  }
  b_box( int w, int h, int d){
    this.dims = new pnt( (float)w,(float)h,(float)d );
  }
    
  pnt[] gen_pnts(){
    
    pnt[] ret = new pnt[8];
    
    for( int i = 0; i < 8 ; i++ ){
      
      pnt temp = new pnt();
      
      if( ( i & 1 ) == 1 ){
        temp.i = this.dims.i;
      }
      
      if( ( i & 2 ) == 2 ){
        temp.j = this.dims.j;
      }
      
      if( ( i & 4 ) == 4 ){
        temp.k = this.dims.k;
      }
      
      temp = temp.p_sub(  this.dims.p_div(2)  );
      
      ret[i] = temp;
      
      }
      return ret;
  }
  
}
