public class Entity {
   
   protected float x, y;
   protected float xVel, yVel;
   protected int xDir;
   protected PImage spritesheet, sprite;
   protected int frame, frameCounter, frameTime;
   
   public Entity(float x, float y) {
      this.x = x;
      this.y = y;
      frame = 0;
      frameCounter = 0;
      xDir = 1;
   }
   
   public void update(Game game) {
   }
   
   public void display(Game game) {
      
   }
}