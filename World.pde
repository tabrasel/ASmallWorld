public class World {
   
   int roomWidth, roomHeight;
   int tileSize;
   float startX, startY;
   
   Tile[][] collisionTiles;
   Tile[][] backgroundTiles;
   Tile[][] foregroundTiles;
   ArrayList<Entity> entities;
   
   PImage tilesheet;
   PImage texture;
   PImage bg;
   
   float moonY;
   int totalFireflies;
   
   public World() {
      roomWidth = 7;
      roomHeight = 7;
      tileSize = 25;
      tilesheet = loadImage("Tilesheet.png");
      bg = loadImage("bg.png");
      entities = new ArrayList<Entity>();
      totalFireflies = 0;
      moonY = height / 2 - 175 / 2 + 40;
      
      String[] collisionData = loadStrings("Collision.txt");
      collisionTiles = new Tile[collisionData.length][collisionData[0].split(" ").length];
      for (int row = 0; row < collisionData.length; row++) {
         String[] rowData = collisionData[row].split(",");
         for (int col = 0; col < rowData.length; col++) {
            String[] tileData = rowData[col].split(" ");
            int tilesheetCol = int(tileData[0]);
            int tilesheetRow = int(tileData[1]);
            collisionTiles[row][col] = new Tile(col * tileSize, row * tileSize, tilesheetCol, tilesheetRow);
            // Set start position
            if (tilesheetCol == 2 && tilesheetRow == 0) {
               startX = col * tileSize + tileSize / 2;
               startY = row * tileSize + tileSize / 2 + 5;
            }
            if (tilesheetCol == 3 && tilesheetRow == 0) {
               entities.add(new Firefly(col * tileSize + tileSize / 2, row * tileSize + tileSize / 2));
               totalFireflies++;
            }
         }
      }
      String[] backgroundData = loadStrings("Background.txt");
      backgroundTiles = new Tile[backgroundData.length][backgroundData[0].split(" ").length];
      for (int row = 0; row < backgroundData.length; row++) {
         String[] rowData = backgroundData[row].split(",");
         for (int col = 0; col < rowData.length; col++) {
            String[] tileData = rowData[col].split(" ");
            int tilesheetCol = int(tileData[0]);
            int tilesheetRow = int(tileData[1]);
            backgroundTiles[row][col] = new Tile(col * tileSize, row * tileSize, tilesheetCol, tilesheetRow);
         }
      }
      String[] foregroundData = loadStrings("Foreground.txt");
      foregroundTiles = new Tile[foregroundData.length][foregroundData[0].split(" ").length];
      for (int row = 0; row < foregroundData.length; row++) {
         String[] rowData = foregroundData[row].split(",");
         for (int col = 0; col < rowData.length; col++) {
            String[] tileData = rowData[col].split(" ");
            int tilesheetCol = int(tileData[0]);
            int tilesheetRow = int(tileData[1]);
            foregroundTiles[row][col] = new Tile(col * tileSize, row * tileSize, tilesheetCol, tilesheetRow);
         }
      }
   }
   
   public void displayCollision(Player player) {
      int startCol = player.getRoomCol() * roomWidth;
      int startRow = player.getRoomRow() * roomHeight; 
      for (int row = startRow; row < startRow + roomHeight; row++) {
         for (int col = startCol; col < startCol + roomWidth; col++) {
            Tile t = collisionTiles[row][col];
            if (t.getTilesheetCol() >= 0 && t.getTilesheetRow() >= 0) {
               texture = tilesheet.get(t.getTilesheetCol() * tileSize, t.getTilesheetRow() * tileSize, tileSize, tileSize);
               image(texture, (col % roomWidth) * tileSize + 1, (row % roomHeight) * tileSize + 1);
            }
         }
      }
   }
   
   public void displayBackground(Player player) {
      int startCol = player.getRoomCol() * roomWidth;
      int startRow = player.getRoomRow() * roomHeight; 
      fill(230, 230, 200);
      noStroke();
      ellipse(width / 2 - 175 / 2 + 50, moonY, 40, 40);
      image(bg.get(startCol * tileSize, startRow * tileSize, 175, 175), width / 2 - 175 / 2, height / 2 - 175 / 2);
      for (int row = startRow; row < startRow + roomHeight; row++) {
         for (int col = startCol; col < startCol + roomWidth; col++) {
            Tile t = backgroundTiles[row][col];
            if (t.getTilesheetCol() >= 0 && t.getTilesheetRow() >= 0) {
               texture = tilesheet.get(t.getTilesheetCol() * tileSize, t.getTilesheetRow() * tileSize, tileSize, tileSize);
               image(texture, width / 2 - 175 / 2 + (col % roomWidth) * tileSize, height / 2 - 175 / 2 + + (row % roomHeight) * tileSize);
            }
         }
      }
   }
   
   public void displayForeground(Player player) {
      int startCol = player.getRoomCol() * roomWidth;
      int startRow = player.getRoomRow() * roomHeight; 
      for (int row = startRow; row < startRow + roomHeight; row++) {
         for (int col = startCol; col < startCol + roomWidth; col++) {
            Tile t = foregroundTiles[row][col];
            if (t.getTilesheetCol() >= 0 && t.getTilesheetRow() >= 0) {
               texture = tilesheet.get(t.getTilesheetCol() * tileSize, t.getTilesheetRow() * tileSize, tileSize, tileSize);
               image(texture, width / 2 - 175 / 2 + (col % roomWidth) * tileSize, height / 2 - 175 / 2 + (row % roomHeight) * tileSize);
            }
         }
      }
   }
   
   public void update(Game game) {
      for (Entity e : entities) {
         e.update(game);
      }
   }
   
   public void displayEntities(Game game) {
      for (Entity e : entities) {
         e.display(game);
      }
   }
   
   public void setMoon() {
      if (moonY < 300) {
         moonY += 0.5;
      }
   }
   
   public int getRoomWidth() {
      return roomWidth;
   }
   
   public int getRoomHeight() {
      return roomHeight;
   }
   
   public int getTileSize() {
      return tileSize;
   }
   
   public Tile[][] getCollisionTiles() {
      return collisionTiles;
   }
   
   public float getStartX() {
      return startX;
   }
   
   public float getStartY() {
      return startY;
   }
   
   public int getTotalFireflies() {
      return totalFireflies;
   }
}