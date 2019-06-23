Ball ball;
LineManager lineManager;

String winner;
int timestamp;
int matchPoint = 4;
  
class GameScene extends Scene{

  int player1Point;
  int player2Point;
  int gamemode = 4;
  int countdown = 4000;
  int iniV = 10;
  
  boolean flagExit = false;
  
  public void initialize(){
    status = "game";
    ball = new Ball();
    lineManager = new LineManager(MAX_HANDS);
    bgm.loop();
  }//初期化関数
  protected void move(){
    if(gamemode == 1){
      ball.move();
    }
    lineManager.moveLines();
  }
    

  protected void render(){
    background(40);
    
    game();
  }
  public void finalize(){
   handManager = new HandManager(MAX_HANDS);
  }//解放関数
  
  void game(){
    lineManager.renderLines();
    lineManager.moveLines();
    stroke(200);
    strokeWeight(2);
    noFill();
    ellipse(width/2,height/2,500,500);
    line(width/2,0,width/2,height);
    if(gamemode == 1){

      
      ball.move();
      ball.render();
    }
      
    if(ball.position.x + ball.ballSize/2 < 0){
      timestamp = millis();
      goal.trigger();
      player1Point += 1;
      if(player1Point > matchPoint){
        winner = "PLAYER 1";
        flagExit = true;
        in = true;
        bgm.pause();
      }
      gamemode = 2; //player1 get point
      ball.velocity.x = random(-iniV,iniV);//ボールを初期位置に
      ball.velocity.y = random(-iniV,iniV);
      ball.position.x = width/2;
      ball.position.y = height/2;
      for(int j=0;j<MAX_HANDS;j++){//線を消す
        if(lineManager.lineArray[j] != null){
          lineManager.lineArray[j].hitPoint = 0;
        }
      }
    }
      
    if(ball.position.x - ball.ballSize/2> width){
      goal.trigger();
      timestamp = millis();
      player2Point += 1;
      if(player2Point > matchPoint){
        winner = "PLAYER 2";
        in = true;
        flagExit = true;
        bgm.pause();
      }
      gamemode = 3; //player2 get point
      ball.velocity.x = random(-iniV,iniV);//ボールを初期位置に
      ball.velocity.y = random(-iniV,iniV);
      ball.position.x = width/2;
      ball.position.y = height/2;
      for(int j=0;j<MAX_HANDS;j++){//線を消す
        if(lineManager.lineArray[j] != null){
          lineManager.lineArray[j].hitPoint = 0;
        }
      }
    }
     
    fill(0,0,255);
    textAlign(CENTER);
    textSize(120);
    text(player1Point,width/2 + 80,80);
    fill(255,0,0);
    text(player2Point,width/2 - 80,80);
    //ゲームモード２，３の時の挙動
    if(gamemode != 1){
      handManager.renderHands();
      textAlign(CENTER);
      textSize(200);
      fill(235);
      if(gamemode == 2){
        fill(100,100,255);
        text("Player1   GOAL!",width/2,height/2);
      }
      if(gamemode == 3){
        fill(255,100,100);
        text("Player2   GOAL!",width/2,height/2);
      }
 
 //カウントダウン部分
      if(timestamp + 1500 <= millis()){
        countdown -= 20;
        if(countdown / 1000 >= 1){
          text(countdown / 1000,width/2,height/2 + 300);
          if(countdown/10==350){
            count.trigger();
          }
          if(countdown/10==250){
            count.trigger();
          }
          if(countdown/10==150){
            count.trigger();
          }
          
        } else if(countdown/100 == 5){
          text("GO!!",width/2,height/2 + 300);
          go.trigger();
        }
        if(timestamp + 4500 <= millis()){
          countdown = 4000;
          gamemode = 1;
        }
      }
    }  
  }
}