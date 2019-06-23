class TitleScene extends Scene{
  boolean flag1 = false;
  boolean flag2 = false;
  public void initialize(){
    status = "title";
     //loadImage 
  }//初期化関数
  
  protected void move(){
    /* エンターでタイトル終了*/
    if(keyPressed && keyCode == ENTER){
      flagExit = true;
    }
    for(int i=0;i<MAX_HANDS;i++){//二人以上でゲームスタート
      if(handManager.handArray[i] != null){
        if(handManager.handArray[i].handData.handState == true
           &&handManager.handArray[i].prevHandData.handState == false){
          //set matchPoint
          if(dist(width/2 + 400,height/2,handManager.handArray[i].handData.pinchX,handManager.handArray[i].handData.pinchY) <= 200){
            matchPoint += 1;
            cursor.trigger();
          }
          if(dist(width/2 - 400,height/2,handManager.handArray[i].handData.pinchX,handManager.handArray[i].handData.pinchY) <= 200 && matchPoint>0){
            matchPoint -= 1;
            cursor.trigger();
          }
          //start game
          if(handManager.handArray[i].handData.pinchX < 800){
            flag1 = true;
            handManager.handArray[i].lineCount = 0;
            join.trigger();
          }
          if(handManager.handArray[i].handData.pinchX > width - 800){
            flag2 = true;
            handManager.handArray[i].lineCount = 0;
            join.trigger();
          }
        }
      }
    }
    if(flag1 && flag2){
      flagExit = true;
      timestamp = millis();
    }
  }

  
  protected void render(){                
    textAlign(CENTER);
    
    background(40);

    noStroke();
    fill(205);
    ellipse(width/2 + 400, height/2,200,200);
    ellipse(width/2 - 400, height/2,200,200);
    pushMatrix();
    fill(200,0,0,180);
    translate(width/2 + 400, height/2);  //中心となる座標
    rotate(radians(-90)); // 左へ90度回転
    //円を均等に3分割する点を結び、三角形をつくる
    beginShape();
    for (int i = 0; i < 3; i++) {
      vertex(50*cos(radians(360*i/3)), 50*sin(radians(360*i/3)));
    }
    endShape(CLOSE);
    popMatrix();
    
    pushMatrix();
    fill(0,0,200,180);
    translate(width/2 - 400, height/2);  //中心となる座標
    rotate(radians(90)); // 左へ90度回転
    //円を均等に3分割する点を結び、三角形をつくる
    beginShape();
    for (int i = 0; i < 3; i++) {
      vertex(50*cos(radians(360*i/3)), 50*sin(radians(360*i/3)));
    }
    endShape(CLOSE);
    popMatrix();

    if(flag1){
      fill(225,0,0,150);
      rect(0,0,width/2,height);
    }
    if(flag2){
      fill(0,0,225,150);
      rect(width/2,0,width/2,height);
    }
        
    textSize(120);
    fill(235,235,235);
    text(matchPoint+1,width/2,height/2);
    text("PINCH TO PLAY!!",width/2,height/2 - 300);
    textSize(60);
    text("matchPoint",width/2,height/2 + 50);
    text("Please pinch your teritory",width/2,height/2+200);
    //image
  }
  
  public void finalize(){
  
  }//解放関数
}