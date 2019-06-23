class Hand extends character{
  
  int mass = 300;
  int malletSize = 350;
  
  float originX;
  float originY;
  
  int lineInterval;
  float lineCount;
  boolean doublePinchable = false;
  boolean lineSwitch = false;
  
  protected HandData handData;
  protected HandData prevHandData;
  
  protected int lastUpdatedTime;
  
  public Hand(){
  handData = new HandData();
  prevHandData = new HandData();
  }

  /* 手データを更新 */
  public void update(HandData srcHandData){
    copyHandData(handData, prevHandData);
    copyHandData(srcHandData, handData);
    lastUpdatedTime = millis();    
    position.x = handData.pinchX;
    position.y = handData.pinchY;
    velocity.x = (handData.pinchX - prevHandData.pinchX);
    velocity.y = (handData.pinchY - prevHandData.pinchY);
     }                     

  public void render(){
    if(lineCount <= 0){
      lineCount = 0;
      lineSwitch = false;
      }
    if(handData.handState == true){
      if(handData.pinchX<width/2){
        fill(255,100,100,150);
      }
      if(handData.pinchX>width/2){
        fill(100,100,255,150);
      }
      noStroke();
      ellipse(handData.pinchX,handData.pinchY,malletSize,malletSize);
    }
      if(doublePinchable){
        lineCount -= 0.08;
      }
      if(handData.handState == true && prevHandData.handState == false && lineCount < 1){//つかんだ時  
        originX = handData.pinchX;
        originY = handData.pinchY;
        lineCount += 0.99;
        doublePinchable = false;
      }
      if(handData.handState == true && sq(handData.pinchX - originX) + sq(handData.pinchY - originY) >= 5 && lineCount < 1){ //不具合防止
        doublePinchable = true;
      }
      if(handData.handState == false && prevHandData.handState == true && lineCount > 1){//放したとき
        doublePinchable = true;
        lineSwitch = true;
        if(currentScene.status == "game"){
          lineManager.makeLine(originX,originY,prevHandData.pinchX,prevHandData.pinchY);
        }
      }
  }
  


  
    public int getID(){
    return handData.id;
  } // getID
  
  /* 更新時刻を得る */
  public int getLastUpdatedTime(){
    return lastUpdatedTime;
  } // getLastUpdatedTime

}