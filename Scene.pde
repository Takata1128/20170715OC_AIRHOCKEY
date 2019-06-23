class Scene{
  
  protected boolean flagExit = false;
  public String status;
  
  public void initialize(){}//初期化関数
  protected void move(){}
  protected void render(){}
  public void finalize(){}//解放関数
  
  public boolean run(){
      move();
      render();
      return flagExit;
  }
}