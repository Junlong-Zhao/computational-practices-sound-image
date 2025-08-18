// Week 10 — Particle Systems (Processing)
// Features: ArrayList-based system, multiple emitters, turbulent wind (Perlin noise),
// mouse gust interaction, three visual modes (petals/leaves/snow).
// Each particle has ≥3 PVectors: position, velocity, acceleration.

// ---------------- Global toggles & state ----------------
ArrayList<Emitter> emitters = new ArrayList<Emitter>();
boolean gravityOn = true;
boolean windOn = true;
int mode = 1;                 // 1: petals, 2: leaves, 3: snow
float t = 0;                  // time for noise
PFont uiFont;

// ---------------- Setup ----------------
void setup() {
  size(980, 560);
  uiFont = createFont("Arial", 14, true);

  // Start with one emitter in the upper-left, one centered
  emitters.add(new Emitter(new PVector(width*0.25, height*0.25)));
  emitters.add(new Emitter(new PVector(width*0.65, height*0.35)));

  // style defaults
  noStroke();
  smooth(8);
}

// ---------------- Draw loop ----------------
void draw() {
  background(18,20,24);
  t += 0.01; // drive turbulent wind

  // update & draw all emitters
  for (Emitter e : emitters) {
    e.updateAndDisplay();
  }

  drawHUD();
}

// ---------------- HUD ----------------
void drawHUD() {
  fill(255);
  textFont(uiFont);
  text(
    "Mode: " + (mode==1?"Petals":mode==2?"Leaves":"Snow") +
    "   G gravity:" + gravityOn + "   W wind:" + windOn +
    "   Click: gust   E: drop emitter   R: reset   S: save   1/2/3 switch",
    12, 22
  );
}

// ---------------- Interaction ----------------
void keyPressed() {
  if (key=='1') mode = 1;
  if (key=='2') mode = 2;
  if (key=='3') mode = 3;

  if (key=='g' || key=='G') gravityOn = !gravityOn;
  if (key=='w' || key=='W') windOn = !windOn;

  if (key=='e' || key=='E') emitters.add(new Emitter(new PVector(mouseX, mouseY)));

  if (key=='r' || key=='R') {
    emitters.clear();
    emitters.add(new Emitter(new PVector(width*0.5, height*0.3)));
  }

  if (key=='s' || key=='S') saveFrame("week10_particles-####.png");
}

void mouseClicked() {
  // Apply a radial gust to particles near the mouse.
  for (Emitter e : emitters) e.gust(mouseX, mouseY);
}

// ========================================================
// ================ Particle System Classes ===============
// ========================================================

class Particle {
  // Core vectors >= 3
  PVector pos;     // position
  PVector vel;     // velocity
  PVector acc;     // acceleration

  // Extra properties
  float life;      // from 1.0 (new) to 0.0 (dead)
  float size;
  float rot;       // rotation angle for petals/leaves
  float dragC;     // drag coefficient (varies by mode)
  int col;         // base color

  Particle(PVector origin) {
    pos = origin.copy();

    // Random initial velocity: slight upward with sideways jitter
    vel = new PVector(random(-0.6, 0.6), random(-0.2, -1.8));
    acc = new PVector();

    life = 1.0;
    size = random(8, 20);
    rot = random(TWO_PI);

    // Visual + physics params depend on global 'mode'
    if (mode == 1) {         // petals
      col = color(255, 120, 160);
      dragC = 0.0035;
      size *= 1.3;
    } else if (mode == 2) {  // leaves
      col = lerpColor(color(255,150,60), color(100,200,120), random(1));
      dragC = 0.0060;
      size *= 1.1;
    } else {                 // snow
      col = color(255);
      dragC = 0.0020;
      size *= 1.0;
    }
  }

  // Apply any external force: F = m*a ; here mass=1 for simplicity
  void applyForce(PVector f) {
    acc.add(f);
  }

  // A simple air-drag proportional to v^2 in the direction opposite to velocity
  void applyDrag() {
    float mag2 = vel.magSq();
    if (mag2 > 0.0001) {
      PVector drag = vel.copy().normalize().mult(-dragC * mag2);
      acc.add(drag);
    }
  }

  // Time-varying turbulent wind based on Perlin noise field
  void applyTurbulentWind() {
    if (!windOn) return;
    float nx = noise(pos.y*0.006f, t);
    float ny = noise(pos.x*0.006f, t+1000);
    // Map noise to a small vector; leaves < petals < snow for horizontal drift
    float amp = (mode==2?0.25f:(mode==1?0.35f:0.5f));
    PVector w = new PVector(map(nx,0,1,-1,1)*amp, map(ny,0,1,-0.2f,0.3f)*0.4f);
    acc.add(w);
  }

  void update() {
    // Forces first
    if (gravityOn) acc.add(0, 0.15);  // gravity
    applyTurbulentWind();
    applyDrag();

    // Integrate
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);

    // Life fades out based on speed + time
    life -= 0.006 + vel.mag()*0.0008;

    // Slight rotation tied to horizontal velocity
    rot += vel.x * 0.05;
  }

  boolean isDead() {
    return life <= 0 || pos.y > height + 40;
  }

  void display() {
    float a = constrain(life, 0, 1);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rot);

    if (mode == 3) {
      // Snow: add a soft glow using additive blend
      blendMode(ADD);
      noStroke();
      fill(255, 200*a);
      ellipse(0, 0, size, size);
      fill(255, 80*a);
      ellipse(0, 0, size*2.1, size*2.1);
      blendMode(BLEND);
    } else if (mode == 2) {
      // Leaf: a small rotated rectangle with vein
      noStroke();
      fill(col, 220*a);
      rectMode(CENTER);
      rect(0, 0, size*1.2, size*0.55, size*0.2);
      stroke(30, 120*a); strokeWeight(1);
      line(-size*0.6, 0, size*0.6, 0);
    } else {
      // Petal: two mirrored ellipses
      noStroke();
      fill(col, 220*a);
      ellipse(-size*0.18, 0, size*0.9, size*0.55);
      ellipse(size*0.18, 0, size*0.9, size*0.55);
      // subtle center tint
      fill(255, 180*a);
      ellipse(0, 0, size*0.35, size*0.35);
    }
    popMatrix();
  }
}

class Emitter {
  PVector pos;
  ArrayList<Particle> particles = new ArrayList<Particle>();
  float spawnRate = 10;      // particles per frame (approx)
  float jitter = 28;         // spawn region radius

  // Slow emitter drift via noise
  float tx = random(1000), ty = random(2000);

  Emitter(PVector p) { pos = p.copy(); }

  void updateAndDisplay() {
    // Drift a little (looks organic)
    tx += 0.005; ty += 0.005;
    pos.x += map(noise(tx), 0,1, -0.6,0.6);
    pos.y += map(noise(ty), 0,1, -0.3,0.7);

    // Emit
    int n = (int) random(spawnRate*0.6, spawnRate*1.4);
    for (int i=0; i<n; i++) {
      PVector o = pos.copy().add(random(-jitter, jitter), random(-jitter*0.4, jitter*0.4));
      particles.add(new Particle(o));
    }

    // Update & draw particles; remove dead
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.update();
      p.display();
      if (p.isDead()) particles.remove(i);
    }

    // Optional: draw a subtle anchor
    noStroke(); fill(255, 30);
    circle(pos.x, pos.y, 3);
  }

  // Mouse gust: push nearby particles away from (mx,my)
  void gust(float mx, float my) {
    PVector center = new PVector(mx, my);
    for (Particle p : particles) {
      float d = PVector.dist(p.pos, center);
      if (d < 160) {
        PVector dir = PVector.sub(p.pos, center);
        dir.normalize();
        // Stronger when closer; add some randomness
        float mag = map(d, 0, 160, 6, 1.5) * random(0.8, 1.2);
        p.vel.add(dir.mult(mag));
      }
    }
  }
}
