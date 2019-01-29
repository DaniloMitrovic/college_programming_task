class slider{
  int sizeW,sizeH;
  String label;
  
  slider(){
    this.sizeW = 100;
    this.sizeH = 10;
    this.label = "slider";
  }
  
  slider( String Label, int sizeW, int sizeH ){
    this.sizeW = sizeW;
    this.sizeH = sizeH;
    this.label = Label;
  }
  
  void draw( int Xo, int Yo){
    
    textSize(12);
    text( this.label, Xo,Yo );
    fill(0,0,0,0);
    rect( Xo+this.label.length()+10, Yo, this.sizeW, this.sizeH );
    fill(0xffffff);
       
  }
  
  
  
}
