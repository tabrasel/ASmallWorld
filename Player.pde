public class Player {
   
   private float x, y;
   private float w, h;
   private int xDir;
   private int roomCol, roomRow;
   private int frame, frameCounter;
   private boolean onGround;
   private float jumpGravity, fallGravity;
   private boolean mouseDown;
   private int firefliesCaught;
   private float startX, startY;
   
   private float xVel, yVel;
   private PImage spritesheet, sprite;
   int animation;
   int[] anims = {1, 2, 1};
   
   public Player(float x, float y) {
      startX = x;
      startY = y;
      respawn();
      jumpGravity = 0.08;
      fallGravity = 0.16;
      xDir = 1;
      frame = 0;
      animation = 0;
      onGround = false;
      spritesheet = loadImage("Player.png");
      sprite = spritesheet.get(24 + (xDir * 8) + (frame * 16), animation * 16, 16, 16);
      firefliesCaught = 0;
   }
   
   public void update(World world) {
      xVel = (mouseX - width / 2) * 0.03;
      
      if (mouseX - width / 2 < 0) {
         xDir = -1;
      } else {
         xDir = 1;
      }
      
      float gravity = fallGravity;
      if (mousePressed) {
         if (onGround && !mouseDown) {
            yVel = -3;
            mouseDown = true;
         }
         if (yVel < 0) {
            gravity = jumpGravity;
         }
      } else {
         if (onGround) {
            mouseDown = false;
         }
      }
      if (xVel < -1.5) {
         xVel = -1.5;
      } 
      if (xVel > 1.5) {
         xVel = 1.5;
      }
      yVel += gravity;
      if (yVel > 4) {
         yVel = 4;
      }
      x += xVel;
      y += yVel;
      collide(world);
      if (onGround) {
         if (abs(xVel) > 0.05) {
            frameCounter++;
            animation = 1;
         } else {
            animation = 0;
         }
      } else {
         animation = 2;
      }
      roomCol = floor(x / (7 * world.getTileSize()));
      roomRow = floor(y / (7 * world.getTileSize()));
   }
   
   public void collide(World world) {
      onGround = false;
      int col = int(x / world.getTileSize());
      int row = int(y / world.getTileSize());
      
      if (col < 1 || col >= world.getCollisionTiles()[0].length) {
         respawn();
      }
      if (row < 1 || row >= world.getCollisionTiles().length) {
         respawn();
      }
      
      col = int(x / world.getTileSize());
      row = int(y / world.getTileSize());
      
      ArrayList<Tile> around = new ArrayList<Tile>();
      if (col >= 0 && col < world.getCollisionTiles()[0].length - 1 && row >= 0 && row < world.getCollisionTiles().length - 1) {
         around.add(world.getCollisionTiles()[row][col]);
         if (row + 1 < world.getCollisionTiles().length) {
            around.add(world.getCollisionTiles()[row + 1][col]);
         }
         if (row - 1 >= 0) {
            around.add(world.getCollisionTiles()[row - 1][col]);
         }
         if (col - 1 >= 0) {
            around.add(world.getCollisionTiles()[row][col - 1]);
         }
         //
         if (col + 1 < world.getCollisionTiles()[0].length) {
            around.add(world.getCollisionTiles()[row][col + 1]);
         }
         if (row + 1 < world.getCollisionTiles().length && col - 1 >= 0) {
            around.add(world.getCollisionTiles()[row + 1][col - 1]);
         }
         if (row + 1 < world.getCollisionTiles().length && col + 1 < world.getCollisionTiles()[0].length) {
            around.add(world.getCollisionTiles()[row + 1][col + 1]);
         }
         if (row - 1 >= 0 && col - 1 >= 0) {
            around.add(world.getCollisionTiles()[row - 1][col - 1]);
         }
         if (row - 1 >= 0 && col + 1 < world.getCollisionTiles()[0].length) {
            around.add(world.getCollisionTiles()[row - 1][col + 1]);
         }
      }
      
      for (Tile t : around) {
         if (t.getTilesheetCol() == 1 && t.getTilesheetRow() == 0) {
            float tileSize = world.getTileSize();
            float tileX = t.getX() + tileSize / 2;
            float tileY = t.getY() + tileSize / 2;
            
            // Horizontal
            if (x - 3 <= tileX + tileSize / 2 && x + 3 >= tileX - tileSize / 2) {
               if (y - 1 <= tileY + tileSize / 2 && y + 1 >= tileY - tileSize / 2) {
                  if (x < tileX) {
                     x = tileX - tileSize / 2 - 3;
                  } else { 
                     x = tileX + tileSize / 2 + 3;
                  }
                  xVel = 0;
               }
            }
             
            // Vertical
            if (x - 1 <= tileX + tileSize / 2 && x + 1 >= tileX - tileSize / 2) {
               if (y - 7 <= tileY + tileSize / 2 && y + 8 >= tileY - tileSize / 2) {
                  if (y < tileY) {
                     if (yVel > 0) {
                        y = tileY - tileSize / 2 - 8;
                        yVel = 0;
                     }
                     onGround = true;
                  } else {
                     if (yVel < 0) {
                        y = tileY + tileSize / 2 + 7;
                        yVel = 0.1;
                     }
                  }
               }
            }
         }
      }   
   }
   
   // Displays the player
   public void display(World world) {
      if (frameCounter > abs(6 / xVel)) {
         frame++;
         frameCounter = 0;
      }
      if (frame > anims[animation] - 1) {
         frame = 0;
      }
      sprite = spritesheet.get(24 + (xDir * 8) + (frame * 16 * xDir), animation * 16, 16, 16);
      float displayX = width / 2 - 175 / 2 + x % (world.getRoomWidth() * world.getTileSize()) - sprite.width / 2;
      float displayY = height / 2 - 175 / 2 + y % (world.getRoomHeight() * world.getTileSize()) - sprite.height / 2;
      image(sprite, displayX, displayY);
      if (firefliesCaught >= world.getTotalFireflies()) {
         textAlign(CENTER, BOTTOM);
         text("wow", displayX, displayY);
      }
   }
   
   // Catch a firefly
   public void catchFirefly() {
      firefliesCaught++;
   }
   
   // Respawns player at the start point
   public void respawn() {
      x = startX;
      y = startY;
      xVel = 0;
      yVel = 0;
   }
   
   public float getX() {
      return x;
   }
   
   public float getY() {
      return y;
   }
   
   public int getRoomCol() {
      return roomCol;
   }
   
   public int getRoomRow() {
      return roomRow;
   }
   
   public int getFirefliesCaught() {
      return firefliesCaught;
   }
}