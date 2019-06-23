class Line {

  float originX;
  float originY;
  float endX;
  float endY;
  float hitPoint = 10;
  
  PVector lineVec;
  PVector ballLineVecO;
  PVector ballLineVecE;

  public Line(float originX, float originY, float endX, float endY) {
    this.originX = originX;
    this.originY = originY;
    this.endX = endX;
    this.endY = endY;
    lineVec = new PVector();
    ballLineVecO = new PVector();
    ballLineVecE = new PVector();
  }

  public void move() {
    lineVec.x = endX - originX;
    lineVec.y = endY - originY;
    ballLineVecO.x = ball.position.x - originX;
    ballLineVecO.y = ball.position.y - originY;
    ballLineVecE.x = ball.position.x - endX;
    ballLineVecE.y = ball.position.y - endY;
    hitPoint -= 0.03;
    //println(hitPoint);
    //hitPoint関連
  }

  public void render() {
    strokeWeight(20);
    if(originX<width/2){
      stroke(255,100,100);
    }
    if(originX>width/2){
      stroke(100,100,255);
    }
    line(originX, originY, endX, endY);
  }
}

class LineManager {
  Line[] lineArray;
  int maxLines;
  
  LineManager(int maxLines){
    this.maxLines = maxLines;
    lineArray = new Line[maxLines];
    for (int i = 0; i < maxLines; i++){
      lineArray[i] = null;    // 最初はnull(空っぽ)
    }
  }
  /* 動かす */
  public void moveLines() {
    for ( int i = 0; i < maxLines; i++ ) {
      if ( lineArray[i] != null ) {
        lineArray[i].move();
        if ( lineArray[i].hitPoint <= 0 ) {        
          lineArray[i] = null;
        }
      }
    }
  } // moveLines

  /* 描く */
  public void renderLines() {
    for ( int i = 0; i < maxLines; i++ ) {
      if ( lineArray[i] != null ) {
        lineArray[i].render();
      }
    }
  } // renderLines  

  /*  */
  public void makeLine( float originX, float originY, float endX, float endY ) {
    for ( int i = 0; i < maxLines; i++ ) {
      if ( lineArray[i] == null ) {
        lineArray[i] = new Line(originX, originY, endX, endY);                   // 空いてる箱を1つ探し、ボールを作る
        break;
      }
    }
  } // makeLine
}