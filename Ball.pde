class Ball extends character{
  protected HandData handData;
  protected HandData prevHandData;
  PVector[] c;
  PVector[] N;
  int mass = 40;
  int ballSize = 150;
  int holdrange = 250;
  float e = 0.7;
  boolean collisionable = true;
  boolean holding = false;
  int interval;
  float picapica;
  public Ball(){
    handData = new HandData();
    prevHandData = new HandData();
    c = new PVector[MAX_HANDS];
    N = new PVector[MAX_HANDS];
    velocity = new PVector(random(-10,10),random(-10,10));
    position = new PVector(width / 2,height / 2);
  }
  void move(){
    //picapica変数 
    picapica = 220 * abs(sin(radians(millis() / 7)));//7で割っているのは適当に点滅を遅くするため。
    //ball2の動作
    position.add(velocity);
    if(position.y + ballSize/2 > height || position.y - ballSize/2 < 0){
      velocity.y = -velocity.y;
      wallReflect.trigger();
    }
    for(int j=0;j<MAX_HANDS;j++){
      if(handManager.handArray[j] != null){
        //ホールド
        if(handManager.handArray[j].handData.handState == true && handManager.handArray[j].prevHandData.handState == false){
          if(position.dist(handManager.handArray[j].position) <= holdrange){
            position.x = handManager.handArray[j].handData.pinchX;
            position.y = handManager.handArray[j].handData.pinchY;
            holding = true;
          }
          if(handManager.handArray[j].handData.handState == false && handManager.handArray[j].prevHandData.handState == true){
            if(position.dist(handManager.handArray[j].position) <= holdrange){
              velocity.x=0;
              velocity.y=0;
            }
          }
        }
        if(holding){
          //position.x = handManager.handArray[j].handData.pinchX;
          //position.y = handManager.handArray[j].handData.pinchY;
          if(handManager.handArray[j].handData.handState == false && handManager.handArray[j].prevHandData.handState == true){
            holding = false;
          }
        }
        //マレットとの衝突
         // collision 
        if(position.dist(handManager.handArray[j].position) <= ballSize/2 + 300/2 && millis() > interval + 100){
          c[j] = (handManager.handArray[j].position.sub(position).normalize());
          velocity = velocity.add(c[j].mult((handManager.handArray[j].velocity.sub(velocity)).dot(c[j]) * (1 + e) * 300/*malletmass*/ / (300/*malletmass*/ + ballSize)));
          interval = millis();
          malletReflect.trigger();
          collisionable = true;
        }
      }
      if(lineManager.lineArray[j] != null){
        //線との衝突
        if(lineManager.lineArray[j].lineVec.cross(lineManager.lineArray[j].ballLineVecO).mag() / lineManager.lineArray[j].lineVec.mag() < ballSize/2){
          if((lineManager.lineArray[j].lineVec.dot(lineManager.lineArray[j].ballLineVecE) * lineManager.lineArray[j].lineVec.dot(lineManager.lineArray[j].ballLineVecO)) <= 0 && collisionable){
            //collision
            N[j] = lineManager.lineArray[j].lineVec.normalize().rotate(90);
            velocity = velocity.sub(N[j].mult(velocity.dot(N[j]) * 2)); 
            wallReflect.trigger();
            collisionable = false;
          }
          if(lineManager.lineArray[j].lineVec.dot(lineManager.lineArray[j].ballLineVecE) * lineManager.lineArray[j].lineVec.dot(lineManager.lineArray[j].ballLineVecO) > 0 && collisionable){
            if(ballSize/2 > lineManager.lineArray[j].ballLineVecE.mag() || ballSize/2 > lineManager.lineArray[j].ballLineVecO.mag()){
              //special collision
              N[j] = lineManager.lineArray[j].lineVec.normalize().rotate(90);
              velocity = velocity.sub(N[j].mult(velocity.dot(N[j]) * 2));
              wallReflect.trigger();
              collisionable = false;
            }
          }
        }
      }
    }
    velocity.limit(33);
  }
 
  void render(){
    noStroke();
    fill(0,255,0,picapica);
    //particle(position.x,position.y);
    ellipse(position.x,position.y,ballSize,ballSize);
   }

  void particle(float position_x,float position_y){
    int light_power = 10;
    int red_power = 100;
    int green_power = 100;
    int blue_power = 255;
    
    loadPixels();
    for(int y=0;y<height;y++){
      for(int x=0;x<width;x++){
        int pixelIndex = x + y*width;
        int r = pixels[pixelIndex] >> 16 & 0xFF;
        int g = pixels[pixelIndex] >> 8 & 0xFF;
        int b = pixels[pixelIndex] & 0xFF;
       
        float dx = (position_x - x)*0.08;
        float dy = (position_y - y)*0.08;
        float distance = sqrt(dx * dx + dy * dy);
       
        if(distance < 1){
          distance = 1;
        }
       
        r += (red_power * light_power) / distance;
        g += (green_power * light_power) / distance;
        b += (blue_power * light_power) / distance;
       
        pixels[pixelIndex] = color(r,g,b);
      }
    }
    updatePixels();
  }
}