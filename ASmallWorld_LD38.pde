Game game;

void setup() {
   size(600, 300);
   noSmooth();
   textSize(12);
   game = new Game();
}

void draw() {
   game.update();
   game.display();
}
