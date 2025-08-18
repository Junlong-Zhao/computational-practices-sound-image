// Week 9 — Bouncing Ball with Mouse Interaction (Vectors + Forces)
// Links: PVector / mouseClicked() / keyPressed() from Processing references.

PVector pos, vel, acc;
float radius = 28;
float mass = 1.0;
float gravity = 0.45;   // downward force magnitude
float restitution = 0.86; // wall bounciness
float dragC = 0.002;    // air drag coefficient

void setup() {
  size(900, 520);
  pos = new PVector(width*0.5, height*0.25);
  vel = new PVector(1.6, 0);
  acc = new PVector();
}

void draw() {
  background(14);
  applyForces();
  integrate();
  checkWalls();

  // draw
  noStroke();
  fill(60, 180, 255);
  circle(pos.x, pos.y, radius*2);

  // HUD
  fill(255);
  text("Click near the ball to 'bounce' it.  S save", 12, 22);
}

void applyForces() {
  // gravity
  acc.add(0, gravity * mass);

  // air drag ~ -c * |v| * v̂
  if (vel.magSq() > 0.0001) {
    PVector drag = vel.copy().normalize().mult(-dragC * vel.magSq());
    acc.add(drag);
  }
}

void integrate() {
  vel.add(acc);
  pos.add(vel);
  acc.mult(0);
}

void checkWalls() {
  // Right/left
  if (pos.x + radius > width) {
    pos.x = width - radius;
    vel.x *= -restitution;
  } else if (pos.x - radius < 0) {
    pos.x = radius;
    vel.x *= -restitution;
  }
  // Bottom/top
  if (pos.y + radius > height) {
    pos.y = height - radius;
    vel.y *= -restitution;
  } else if (pos.y - radius < 0) {
    pos.y = radius;
    vel.y *= -restitution;
  }
}

// Mouse adds an impulse away from the cursor (stronger if closer)
void mouseClicked() {
  PVector toBall = PVector.sub(pos, new PVector(mouseX, mouseY));
  float d = max(1, toBall.mag());
  if (d < 160) { // only if close enough
    PVector impulse = toBall.normalize().mult(map(d, 0, 160, 12, 2));
    vel.add(impulse);
  }
}

void keyPressed() {
  if (key=='s' || key=='S') saveFrame("week09_ball-####.png");
}
