

int direction = 0; // 1 = up 2= right 3= down 4= left
int frame = 0;
int level = 1;
float gridSize = 10;
int playerOffset = 100;
float inputTimer = 0;
int pauseTimer = 45;
boolean gameOver = false;

Player player = new Player(0, 0, 0);
ArrayList<ArrayList<Obstacle>> obstacles = new ArrayList<ArrayList<Obstacle>>();



public void setup(){
    size(1000,1000);
    textAlign(TOP);
    player.changeDotSize(100);
    player.changeDotPos(width/ gridSize  * (gridSize / 2) + (player.getDotSize() / 2) , height - (player.getDotSize()/ 2));
    generateObstacles();
    background(0);
    fill(255);
    textSize(250);
    text("Get Ready", 250, 250, 750, 750);
    textSize(12);
}




public class Dot{
  
    float dotX, dotY;
    float size;
          
    public Dot(float x , float y, float s){
      dotX = x;
      dotY = y;
      size = s;
      
    }
    
    void changeDotPos(float x, float y){
      dotX = x; 
      dotY = y;
      
    }
    
    void changeDotSize(float s){
      size = s;   
      
    }  
    
    void drawDot(int r, int g, int b){
      fill(r, g, b);
      circle(dotX, dotY, size);
      
    }
    
    float getDotSize(){
      return(size);
      
    }  
    
    float getDotX(){
      return(dotX);
      
    }
    
    float getDotY(){
      return(dotY);
      
    }  
    void moveDot(float x, float y){
      dotX += x;
      dotY += y;
      
    }
    
    void setSize(float i){
      size = i;  
      
    }  
  
  
}



public class Obstacle extends Dot{
    float speed;
    boolean movingLeft;
    
  
    public Obstacle(float x, float y, float s, float sp, boolean l){
      super(x, y, s);
      speed = sp;
      movingLeft = l;
      
    }  
  
    void changeMovingLeft(boolean l){
      movingLeft = l; 
      
    }
    
    void changeSpeed(float s){
      speed = s;  
      
    } 
    
    void moveDot(){
      float s = speed;
      
      if(movingLeft){
        s = -s;
        
      }  
        
      dotX += s;
      
      if(!(dotX <= (1000 + size) && (dotX + size)  >= 0)){
        if(movingLeft){
          dotX = width + size;
          
        } else {
          dotX = 0 - size;  
          
        }  
        
      }
      
    }  
  
}



public class Player extends Dot{
  
    public Player(float x, float y, float s){
      super(x, y, s);  
      
    }  
   
   
    void drawDot(int r, int g, int b){
      fill(r, g, b);
      circle(dotX, dotY, size/3);
      
    }
   
    
    void moveDot(float x , float y){
      if(dotX + x < 1000 && dotX + x  > 0){
        dotX += x;    
        
      }  
      
      if(dotY + y  < 1000){
        dotY += y;    
        
      }  
      
      
    }  

  
}  



public void collision(){
    final float offset = ((obstacles.get(0).get(0).getDotSize()/2) + (player.getDotSize()/10)); 
    
    //println("row " + row);
    for(int i = 0; i < obstacles.size() && !gameOver; i++){    
      for(int h = 0; h < obstacles.get(i).size() && !gameOver; h++){  
        //println("row: " + i);
        //println("column "  + h);
        
        gameOver = player.getDotX() > obstacles.get(i).get(h).getDotX() - offset
        && player.getDotX() < obstacles.get(i).get(h).getDotX() + offset
        && player.getDotY() >  obstacles.get(i).get(h).getDotY() - 1
        && player.getDotY() <  obstacles.get(i).get(h).getDotY() + 1;
        
        //println("offset: " + offset);
        //println("left bound " + (obstacles.get(i).get(h).getDotX() - offset) );
        //println("right bound " + (obstacles.get(i).get(h).getDotX() + offset));
        //println("ob X: " + obstacles.get(i).get(h).getDotX());
        //println("ob Y: " + obstacles.get(i).get(h).getDotY());
        //println("pl X: " + player.getDotX());
        //println("pl Y: " + player.getDotY());
        
        
      }
      
    }
    
}  



public boolean detectOverlap(ArrayList<Obstacle> array, int c){
    boolean overlap = false;
    float currentX = array.get(c).getDotX();
    float dotSize = array.get(0).getDotSize();
    
    
    //println("array size " + array.size());
    //println("current spot " + c);
    //println(currentX);
    if(!(c == 0)){
    for(int i = 0; i < c && !overlap ; i++){
      //println(i);
      //println(array.get(i).getDotX());

      overlap = currentX > array.get(i).getDotX() - (dotSize) 
      && currentX < array.get(i).getDotX() + (dotSize);
      
   
      //println(overlap);
      
    }  
    }
  
    return(overlap);  
}



public void drawObstacles(){     
    for(int i = 0;i < obstacles.size(); i++){
      for(int h = 0; h < obstacles.get(i).size(); h++){
        obstacles.get(i).get(h).drawDot(255, 0, 25);         
         
      }  
      
    }
  
    
}  



public void game(){
    background(28, 158, 63);  
    gameBackground();
             
    for (int i = 0;i < obstacles.size(); i++){
      for(int h = 0; h < obstacles.get(i).size(); h++){
        obstacles.get(i).get(h).moveDot();         
         
      }
       
    }  
    
    player.drawDot(0, 255, 0);
    drawObstacles();
      
    fill(0);
    textSize(50);
    textAlign(CENTER);
    text("Level " + level, 550, 50);
    
    if(player.dotY < 0){
      level += 1;
   
      if(level < 10){
        gridSize += 2;
        playerOffset -= 5;
        player.changeDotSize(width/gridSize);
      
      }
      
      player.changeDotPos(width/ gridSize  * (gridSize / 2) + (player.getDotSize() / 2) , height - (player.getDotSize()/ 2));
      background(0);
      fill(255);
      textSize(250);
      text("Next Level", 250, 250, 750, 750);
      textSize(12);
      generateObstacles();   
      pauseTimer = 45;
    
    }
    
    collision();
    //println(gameOver);


}



public void gameBackground(){
    fill(10, 100 ,10);
    noStroke();
    
    for(int i = 0; i < gridSize ; i += 2){
      rect((i) * width/gridSize, 0, width/gridSize, height);
      
    }
  
    stroke(0);
 
  
}  



public void generateObstacles(){
    int rows = int(gridSize) - 2;
    
    for(int i = obstacles.size();i <= rows; i++){
      obstacles.add(new ArrayList<Obstacle>()); 
      
    }
    
    for(int i = 0;i < rows; i++){
       for(int h = obstacles.get(i).size(); h <= (gridSize/2) - 4; h++){
         boolean left = (i % 2) == 0;
         
         obstacles.get(i).add(new Obstacle(0, 0, 0, 0, left));  
         
       }  
      
    }
    
    for(int i = 0;i < rows; i++){
      float speed = random(1,4);
       
      for(int h = 0; h < obstacles.get(i).size(); h++){
        obstacles.get(i).get(h).changeSpeed(speed);
        obstacles.get(i).get(h).changeDotSize(width/gridSize);  
        
        
        do {
           obstacles.get(i).get(h).changeDotPos(genObstaclePos(), ((i + 2) * (width / gridSize)) - (obstacles.get(0).get(0).getDotSize() / 2));    
          
         } while(detectOverlap(obstacles.get(i), h));
         
       }  
      
     }
  
  
}  



public int genObstaclePos(){
    float pos = random(1, width); 
    
  
    return(int(pos));
    
    
}  



void keyReleased(){
    if(pauseTimer == 0 && !gameOver){
      switch(key){
          case 'w':
            player.moveDot(0, -(height/gridSize));
            break;
             
          case 'd':
            player.moveDot(width/gridSize, 0);
            break;
              
          case 's':
            player.moveDot(0, height/gridSize);
            break;
              
          case 'a':
            player.moveDot(-(width/gridSize), 0);
            break;
                
          case 'i':
            player.moveDot(0, -(height/gridSize));
            break;
             
          case 'l':
            player.moveDot(width/gridSize, 0);
            break;
              
          case 'k':
            player.moveDot(0, height/gridSize);
            break;
              
          case 'j':
            player.moveDot(-(width/gridSize), 0);
            break;
              
       }    
         
    
      if(!keyPressed){     
        inputTimer = 0;
        
      }   
    
    }
    
    
}  



void keyPressed(){
    if(pauseTimer == 0 && !gameOver){  
      inputTimer += 1;
      
      if(inputTimer > 1){
        switch(key){
            case 'w':
              player.moveDot(0, -(height/gridSize));
              break;
               
            case 'd':
              player.moveDot(width/gridSize, 0);
              break;
                
            case 's':
              player.moveDot(0, height/gridSize);
              break;
                
            case 'a':
              player.moveDot(-(width/gridSize), 0);
              break;
                  
            case 'i':
              player.moveDot(0, -(height/gridSize));
              break;
               
            case 'l':
              player.moveDot(width/gridSize, 0);
              break;
                
            case 'k':
              player.moveDot(0, height/gridSize);
              break;
                
            case 'j':
              player.moveDot(-(width/gridSize), 0);
              break;
                
        }    
        
      }
      
    }
    
  
}




void draw(){
    if(pauseTimer == 0 && !gameOver){      
      game();
          
      }else if(gameOver){
        textAlign(LEFT);
        fill(0, 0, 0);
        stroke(0);
        strokeWeight(6);
        textSize(255);
        text("GAME OVER", 205, 250, 750, 750);      
        fill(250, 0, 0);
        textSize(250);
        text("GAME OVER", 200, 250, 750, 750);
      
    } else {
      pauseTimer -= 1; 
       
    }  
    //println("FPS: " + frameRate);
    //println(gameOver);
    //println(player.getDotY() / (height / gridSize));
    //println(obstacles.size());
    
    
}
