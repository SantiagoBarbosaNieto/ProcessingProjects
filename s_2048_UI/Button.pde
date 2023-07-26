class Button{
  
  PVector pos;
  PVector tam;
  int col;
  private String action;
  Button(int x, int y, int w, int h, int col, String action)
  {
    pos = new PVector(x,y);
    tam = new PVector(w,h);
    this.col = col;
    this.action = action;
  }
  
  void show()
  {
    fill(color(col));
    rect(pos.x,pos.y,tam.x,tam.y, tam.x/10);
    fill(10);
    textAlign(CENTER,CENTER);
    textSize(this.tam.y*3/5);
    text(this.action,this.pos.x + this.tam.x/2, this.pos.y + this.tam.y/2 - 5);
  }
  
  String getAction()
  {
    return this.action;
  }



}
