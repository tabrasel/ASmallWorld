public class Firefly extends Entity {
   
   private boolean hasBeenCaught;
   private float springiness;
   private float maxProximity;
   private float targetXOffset, targetYOffset;
   private float startX, startY;
   
   public Firefly(float x, float y) {
      super(x, y);
      startX = x;
      startY = y;
      spritesheet = loadImage("Firefly.png");
      sprite = spritesheet.get(frame * 16, 0, 16, 16);
      hasBeenCaught = false;
      springiness = random(0.0005, 0.002);
      maxProximity = random(10, 18);
      frameTime = int(random(2, 6));
   }
   
   // Update the firefly
   public void update(Game game) {
      if (hasBeenCaught) {
         if (random(1.0) < 0.05) {
            setTargetOffset();
         }
         if (dist(game.getPlayer().getX(), game.getPlayer().getY(), x, y) <= maxProximity) {
            xVel -= (game.getPlayer().getX() - x) * springiness * 4;
            yVel -= (game.getPlayer().getY() - y) * springiness * 4;
         } else {
            xVel += (game.getPlayer().getX() + targetXOffset - x) * springiness;
            yVel += (game.getPlayer().getY() + targetYOffset - y) * springiness;
         }
         if (game.getPlayer().getX() - x < 0) {
            xDir = -1;
         } else {
            xDir = 1;
         }
      } else {
         if (random(1.0) < 0.05) {
            setTargetOffset();
         }
         if (dist(game.getPlayer().getX(), game.getPlayer().getY(), x, y) <= 25) {
            setTargetOffset();
            hasBeenCaught = true;
            game.getPlayer().catchFirefly();
         }
         xVel += (startX + targetXOffset - x) * springiness;
         yVel += (startY + targetYOffset - y) * springiness;
         if (xVel < 0) {
            xDir = -1;
         } else {
            xDir = 1;
         }
      }
      xVel *= 0.98;
      yVel *= 0.98;
      x += xVel;
      y += yVel;
   }
   
   public void display(Game game) {
      frameCounter++;
      if (frameCounter > frameTime) {
         frame++;
         frameCounter = 0;
      }
      if (frame > spritesheet.width / 2 / 16 - 1) {
         frame = 0;
      }
      sprite = spritesheet.get(24 + (xDir * 8) + (frame * 16 * xDir), 0, 16, 16);
      
      World world = game.getWorld();
      Player player = game.getPlayer();
      float displayX = width / 2 - 175 / 2 + (x - player.getRoomCol() * world.getRoomWidth() * world.getTileSize()) - sprite.width / 2;
      float displayY = height / 2 - 175 / 2 + (y - player.getRoomRow() * world.getRoomHeight() * world.getTileSize()) - sprite.height / 2;
      image(sprite, displayX, displayY);
   }
   
   // Sets the new random target offset
   private void setTargetOffset() {
      targetXOffset = random(-8, 8);
      targetYOffset = random(-8, 8);
   }
}