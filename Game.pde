public class Game {
   
   World world;
   Player player;
   color skyColor;
   float skyChange;
   
   public Game() {
      world = new World();
      player = new Player(world.getStartX(), world.getStartY());
      skyChange = 0;
      skyColor = color(40, 80, 180);
   }
   
   // Update the game
   public void update() {
      player.update(world);
      world.update(this);
   }
   
   // Display the game
   public void display() {
      background(skyColor);
      world.displayBackground(player);
      world.displayEntities(this);
      player.display(world);
      world.displayForeground(player);
      
      // Display black border
      noStroke();
      fill(0);
      rect(0, 0, width / 2 - 175 / 2, height);
      rect(width / 2 - 175 / 2 + 175, 0, width / 2 - 175 / 2, height);
      rect(width / 2 - 175 / 2, 0, 175, height / 2 - 175 / 2);
      rect(width / 2 - 175 / 2, height / 2 - 175 / 2 + 175, 175, height / 2 - 175 / 2);
      
      // Display joystick
      fill(255);
      stroke(255);
      line(width / 2, 260, constrain(mouseX, width / 2 - 50, width / 2 + 50), 260);
      ellipse(constrain(mouseX, width / 2 - 50, width / 2 + 50), 260, 10, 10);
      
      // Display how many fireflies you have caught
      textAlign(CENTER, CENTER);
      text(player.getFirefliesCaught() + "/" + world.getTotalFireflies(), width / 2, 40);
      if (player.getFirefliesCaught() >= world.getTotalFireflies()) {
         world.setMoon();
         if (skyChange < 90) {
            skyChange += 0.2;
         }
         skyColor = color(40 + skyChange, 80 + skyChange, 180 + skyChange);
         fill(255);
         textAlign(CENTER, CENTER);
         text("THE END", (width / 2 - 175 / 2) / 2, height / 2);
         text("THANK YOU FOR PLAYING", width - (width / 2 - 175 / 2) / 2, height / 2);
      }
   }
   
   // Returns the player
   public Player getPlayer() {
      return player;
   }
   
   // Returns the world
   public World getWorld() {
      return world;
   }
}