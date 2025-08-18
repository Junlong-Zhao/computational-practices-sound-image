// Week 9 — Mini Game "Flower Glide"
// Requirements satisfied:
//  - ≥1 class: Player, Flower
//  - ≥2 forces: gravity + drag (also optional attractor & mouse gust)
//  - ≥1 interaction: keyboard thrust, mouse gust, toggles
//
// Controls:
//   ←/→ horizontal thrust, SPACE short upward boost
//   Mouse click: wind gust from cursor (pushes player)
//   E toggle attractor, R reset, S save

// ---------- Player ----------
class Player {
  PVector pos, vel, acc;
  float mass = 1.0;
  float radius = 20;

  Player(float x, float y){
    pos = new PVector(x,y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  }

  void applyForce(PVector f){ acc.add(PVector.div(f, mass)); }

  void update(){
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }

  void edgesBounce(float e){
    if (pos.x + radius > width){ pos.x = width - radius; vel.x *= -e; }
    if (pos.x - radius < 0){ pos.x = radius; vel.x *= -e; }
    if (pos.y + radius > height){ pos.y = height - radius; vel.y *= -e; }
    if (pos.y - radius < 0){ pos.y = radius; vel.y *= -e; }
  }

  void draw(){
    noStroke();
    fill(255, 240, 180);
    circle(pos.x, pos.y, radius*2);
    // heading indicator
    stroke(40,120,255); strokeWeight(3);
    PVector dir = vel.copy().setMag(18);
    line(pos.x, pos.y, pos.x + dir.x, pos.y + dir.y);
  }
}

// ---------- Flower ----------
class Flower {
  PVector pos; boolean got=false;
  Flower(float x, float y){ pos = new PVector(x,y); }
  void draw(){
    if (got) return;
    pushMatrix();
    translate(pos.x, pos.y);
    noStroke(); fill(255,80,120);
    for(int i=0;i<6;i++){
      float a = TWO_PI*i/6.0;
      ellipse(16*cos(a), 16*sin(a), 12, 18);
    }
    fill(255,220,0); circle(0,0,12);
    popMatrix();
  }
  boolean tryCollect(Player p){
    if (!got && PVector.dist(p.pos, pos) < p.radius + 14){ got = true; return true; }
    return false;
  }
}

// ---------- Globals ----------
Player player;
ArrayList<Flower> flowers = new ArrayList<Flower>();
int score = 0;
boolean attractorOn = true;

float gravityMag = 0.40;
float dragC = 0.0025;
float restitution = 0.9;

// Attractor (e.g., a “space breeze” or worm gravity)
PVector attractorPos;

void setup(){
  size(980, 560);
  resetGame();
}

void resetGame(){
  player = new Player(width*0.15, height*0.3);
  flowers.clear();
  // scatter 10 flowers
  for (int i=0;i<10;i++){
    float x = random(width*0.25, width*0.95);
    float y = random(height*0.15, height*0.85);
    flowers.add(new Flower(x,y));
  }
  score = 0;
  attractorPos = new PVector(width*0.7, height*0.5);
}

void draw(){
  background(18,20,24);

  // --- Forces on player ---
  // gravity
  player.applyForce(new PVector(0, gravityMag * player.mass));
  // air drag
  if (player.vel.magSq() > 0.0001){
    PVector drag = player.vel.copy().normalize().mult(-dragC * player.vel.magSq());
    player.applyForce(drag);
  }
  // attractor (optional)
  if (attractorOn){
    PVector dir = PVector.sub(attractorPos, player.pos);
    float d = constrain(dir.mag(), 30, 260);
    dir.normalize();
    float strength = 180.0 / (d*d);      // inverse-square
    player.applyForce(dir.mult(strength));
  }

  // keyboard thrust
  if (keyPressed){
    if (keyCode == LEFT)  player.applyForce(new PVector(-0.8, 0));
    if (keyCode == RIGHT) player.applyForce(new PVector( 0.8, 0));
  }

  // integrate & bounce
  player.update();
  player.edgesBounce(restitution);

  // draw attractor
  if (attractorOn){
    noStroke(); fill(80,140,255,100);
    circle(attractorPos.x, attractorPos.y, 36);
  }

  // draw flowers & collect
  for (Flower f : flowers){
    f.draw();
    if (f.tryCollect(player)) score++;
  }

  // player
  player.draw();

  // UI
  fill(255);
  text("Score: "+score+"/10   (←/→ thrust, SPACE boost, mouse click gust)"
      +"   [E] attractor: "+attractorOn+"   [R] reset   [S] save", 12, 22);

  // end states
  if (score >= 10){
    showEnd("You collected all flowers!  Press R to restart.");
    noLoop();
  } else if (player.pos.y - player.radius > height + 40){
    showEnd("You fell… Press R to try again.");
    noLoop();
  }
}

void showEnd(String msg){
  fill(0, 180); noStroke();
  rect(0,0,width,height);
  fill(255); textAlign(CENTER, CENTER); textSize(24);
  text(msg, width/2.0, height/2.0);
  textAlign(LEFT, BASELINE); textSize(14);
}

void keyPressed(){
  if (key == ' '){  // short upward boost
    player.vel.add(0, -8);
  }
  if (key=='e' || key=='E') attractorOn = !attractorOn;
  if (key=='r' || key=='R'){ loop(); resetGame(); }
  if (key=='s' || key=='S') saveFrame("week09_game-####.png");
}

void mouseClicked(){
  // wind gust from mouse towards the player
  PVector gust = PVector.sub(player.pos, new PVector(mouseX,mouseY));
  float d = max(1, gust.mag());
  if (d < 220){
    gust.normalize().mult(map(d, 0, 220, 14, 3));
    player.vel.add(gust);   // impulse
  }
}
