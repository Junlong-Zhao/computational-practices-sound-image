// Week 4 — Perlin Noise demo
// Keys: [ / ] to change scale, A to toggle animation, S to save a frame

float z = 0.0;            // time dimension for animated noise
float zSpeed = 0.01;      // how fast noise evolves in time
float scale = 120.0;      // spatial scale (bigger = smoother)
boolean anim = true;

void setup() {
  size(700, 450);
  pixelDensity(displayDensity());
  noStroke();
  noiseDetail(5, 0.5);     // 5 octaves, falloff 0.5 (nice general-purpose setting)
}

void draw() {
  loadPixels();
  // Render a grayscale noise texture
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      // Using 3D noise (x,y,z). Dividing by scale makes it smoother.
      float n = noise(x/scale, y/scale, z);
      int val = int(n * 255.0);
      pixels[x + y*width] = color(val);
    }
  }
  updatePixels();

  // Heads-up display
  fill(0, 150);
  rect(0, 0, 285, 52);
  fill(255);
  text("Perlin noise — scale: " + nf(scale,1,1) + "  z: " + nf(z,1,2) +
       "  anim: " + anim + "\n[ / ] scale   A animate   S save", 10, 18);

  if (anim) z += zSpeed;
}

void keyPressed() {
  if (key == '[') { scale = max(20, scale - 10); }
  if (key == ']') { scale = min(400, scale + 10); }
  if (key == 'a' || key == 'A') anim = !anim;
  if (key == 's' || key == 'S') saveFrame("week04_noise-####.png");
}
