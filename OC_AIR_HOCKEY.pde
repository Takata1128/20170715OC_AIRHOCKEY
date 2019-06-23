Scene currentScene;
HandManager handManager;
import ddf.minim.*;

AudioSample wallReflect;
AudioSample malletReflect;
AudioSample congratulation;
AudioSample goal;
AudioSample join;
AudioSample go;
AudioSample count;
AudioSample cursor;
AudioPlayer bgm;

PFont rafale;
PFont trench;

PImage space;

Minim minim;
void setup(){
  
  fullScreen(P3D);
  //size(1920,1080);
  //size(968,554);
  //size(3840,2160,P3D);
  initialize();
  
  minim = new Minim(this);
  
  handManager = new HandManager(MAX_HANDS);
  
  currentScene = new TitleScene();
  currentScene.initialize();
  
  wallReflect = minim.loadSample("shot1.mp3");
  malletReflect =minim.loadSample("shot2.mp3");
  congratulation = minim.loadSample("cong.mp3");
  join = minim.loadSample("menu2.mp3");
  bgm = minim.loadFile("crazycat.mp3");
  go = minim.loadSample("decision13.mp3");
  count = minim.loadSample("decision1.mp3");
  goal = minim.loadSample("train-horn2.mp3");
  cursor = minim.loadSample("cursor10.mp3");
  
  rafale = loadFont("Rafale-RU-48.vlw");
  trench = loadFont("Trench-Thin-48.vlw");
  
  space = loadImage("SPACE.jpg");
}


boolean in ;
void draw(){
  textFont(trench);

  
  if ( currentScene.run() == true ){
  
    currentScene.finalize();
    
    if(currentScene.status == "title"){
      currentScene = new GameScene();
      currentScene.initialize();
    }
    
    else if(currentScene.status == "game" ){
      currentScene = new EndingScene();
      currentScene.initialize();
    }
    
    else if(currentScene.status == "result"){
      currentScene = new TitleScene();
      currentScene.initialize();
    }
    
  }  
  
    if(in){ 
      if(currentScene.status == "game"){
        currentScene = new EndingScene();
        currentScene.initialize();
        in = false;
      }
      else if(currentScene.status == "result"){
        currentScene = new GameScene();
        currentScene.initialize();
        in = false;
      }
    }
  
  /* 手の更新 */
  handManager.updateHands(handDataArray);
   /* 手の描画 */
  handManager.renderHands(); 
  
  if(keyPressed && keyCode == ESC){
    exit();
  }
  
}//draw

void stop(){
  wallReflect.close();
  malletReflect.close();
  congratulation.close();
  bgm.close();
  goal.close();
  go.close();
  count.close();
  join.close();
  minim.stop();
  super.stop();
}