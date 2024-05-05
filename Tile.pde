public class Tile {
   
   private float x, y;
   private int tilesheetCol, tilesheetRow;
   
   public Tile(float x, float y, int tilesheetCol, int tilesheetRow) {
      this.x = x;
      this.y = y;
      this.tilesheetCol = tilesheetCol;
      this.tilesheetRow = tilesheetRow;
   }
   
   public float getX() {
      return x;
   }
   
   public float getY() {
      return y;
   }
   
   public int getTilesheetCol() {
      return tilesheetCol;
   }
   
   public int getTilesheetRow() {
      return tilesheetRow;
   }
}