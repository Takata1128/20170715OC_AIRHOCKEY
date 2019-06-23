class EndingScene extends Scene{
  boolean flag1 = false;
  boolean flag2 = false;
  
  boolean soundEffect = false;
  boolean flagExit = false;
  public void initialize(){
    status = "result";
    timestamp = millis();
     //loadImage 
  }//初期化関数
  
  protected void move(){
    /* エンターでタイトル終了*/
    if(keyPressed && keyCode == ENTER){
      flagExit = true;
    }
    
    for(int i=0;i<MAX_HANDS;i++){//二人以上でもう一回
      if(handManager.handArray[i] != null){
        if(handManager.handArray[i].handData.handState == true
           &&handManager.handArray[i].prevHandData.handState == false
           &&timestamp +3000 < millis()){
          if(handManager.handArray[i].handData.pinchX < width/2 - 500){
            flag1 = true;
            join.trigger();
          }
          else if(handManager.handArray[i].handData.pinchX > width/2 + 500){
            flag2 = true;
            in = false;
            join.trigger();
          }
        }
      }
    }
    if(flag1 && flag2){
      flagExit = true;
      in = true;
      timestamp = millis();
      soundEffect = false;
    }
  }
  
  protected void render(){
    textAlign(CENTER,CENTER);
    
    background(40);
    
    noStroke();
    if(flag1){
      fill(255,0,0,150);
      rect(0,0,width/2,height);
    }
    if(flag2){
      fill(0,0,255,150);
      rect(width/2,0,width/2,height);
    }
    
    fill(235);
    textSize(160);
    text(winner + "  IS  WINNER!",width/2,height/2);
    textSize(80);
    text("Please pinch your teritory to rematch",width/2,height/2+200);
    while(soundEffect == false && flagExit == false){
      congratulation.trigger();
      soundEffect = true;
    }
    
    //image
  }
  
public void finalize(){
  }//解放関数
}