class GUI{
  
  ArrayList<Button> btns;
  ArrayList<Integer> colors;

  Button btnReset;
  
  GUI(ArrayList<Integer> colors)
  {
    this.colors = colors;
    btns = new ArrayList<Button>();
    
    offset = new PVector(30,height*20/100);
    
    g = new Game(offset, colors);
    
    btnReset = new Button(30,int(height-(height-width-offset.y)), width/3, height/10, colors.get(0), "Reset");
    btns.add(btnReset);
 }
  
 void show()
 {
   g.show();
   btnReset.show();
 }
  
 void update()
 {
   
 }
 
 
 String checkBoundaries(int x, int y)
 {
   for(Button btn: btns)
   {
     
     if((x > btn.pos.x && x < btn.pos.x + btn.tam.x)&& (y > btn.pos.y && y < btn.pos.y + btn.tam.y))
     {
       return btn.getAction();
     }
   }
   
   return "NONE";
   
 }
  
}
