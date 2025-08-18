// Week 4 — Filters + Masking (Processing)
// Base filter applies to the whole image; a different filter applies inside a circular mask around the mouse.
//
// Controls:
// 1 None     2 Invert   3 Bright+40   4 Contrast+40   5 Duotone(blue/orange)   6 Sepia
// a None     s Invert   d Bright+60   f Contrast+80   g Duotone(magenta/teal)  h Sepia
// UP / DOWN  change mask radius
// R reset    S save current frame
//
// References used in formulas:
// - Contrast factor (DF Studios): https://www.dfstudios.co.uk/.../image-processing-algorithms-part-5-contrast-adjustment/
// - Sepia matrix (GeeksForGeeks): https://www.geeksforgeeks.org/java/image-processing-in-java-colored-image-to-sepia-image-conversion/

PImage src;            // original image
PImage working;        // buffer used for output
PFont  hud;
float radius = 120;

int baseMode = 1;      // 1..6
int innerMode = 1;     // a/s/d/f/g/h mapped to 1..6

void setup() {
  size(900, 600);
  pixelDensity(displayDensity());
  hud = createFont("Arial", 13);

  // Try loading example.jpg from the sketch folder.
  // If not found, generate a simple gradient placeholder.
  try {
    src = loadImage("example.jpg");
  } catch(Exception e) { src = null; }

  if (src == null) {
    src = createImage(width, height, RGB);
    src.loadPixels();
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        float t = map(x, 0, width, 0, 1);
        src.pixels[x + y*width] = lerpColor(color(240,240,255), color(200,220,255), t);
      }
    }
    src.updatePixels();
  } else {
    src.resize(width, height);  // fit canvas
  }

  working = createImage(width, height, RGB);
}

void draw() {
  // Step 1: apply the base filter to the whole image
  applyFilterToImage(src, working, baseMode);

  // Step 2: apply the inner filter only inside a circular mask around the mouse
  PImage inner = createImage(width, height, RGB);
  applyFilterToImage(src, inner, innerMode);

  // Combine using the circular mask (dist-based)
  working.loadPixels();
  inner.loadPixels();
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int i = x + y*width;
      if (dist(x, y, mouseX, mouseY) < radius) {
        working.pixels[i] = inner.pixels[i];
      }
    }
  }
  working.updatePixels();

  image(working, 0, 0);

  // Draw the mask circle
  noFill();
  stroke(0, 180);
  strokeWeight(2);
  ellipse(mouseX, mouseY, radius*2, radius*2);

  // HUD
  drawHUD();
}

void drawHUD() {
  String[] names = {
    "None", "Invert", "Brightness", "Contrast", "Duotone", "Sepia"
  };
  String baseName  = names[baseMode-1];
  String innerName = names[innerMode-1];

  noStroke();
  fill(0, 140);
  rect(0, 0, 560, 64);
  fill(255);
  textFont(hud);
  text("Base filter [1..6]: " + baseName +
       "     Inner filter [a,s,d,f,g,h]: " + innerName +
       "     Radius: " + int(radius), 12, 20);
  text("Keys: 1 None  2 Invert  3 Bright+40  4 Contrast+40  5 Duotone(blue/orange)  6 Sepia", 12, 38);
  text("      a None  s Invert  d Bright+60  f Contrast+80  g Duotone(magenta/teal)  h Sepia   ↑/↓ radius   R reset   S save", 12, 56);
}

void keyPressed() {
  if (key == '1') baseMode = 1;
  if (key == '2') baseMode = 2;
  if (key == '3') baseMode = 3;
  if (key == '4') baseMode = 4;
  if (key == '5') baseMode = 5;
  if (key == '6') baseMode = 6;

  if (key == 'a' || key == 'A') innerMode = 1;
  if (key == 's' || key == 'S') innerMode = 2;
  if (key == 'd' || key == 'D') innerMode = 3;
  if (key == 'f' || key == 'F') innerMode = 4;
  if (key == 'g' || key == 'G') innerMode = 5;
  if (key == 'h' || key == 'H') innerMode = 6;

  if (keyCode == UP)   radius = min(radius + 10, 400);
  if (keyCode == DOWN) radius = max(radius - 10, 20);

  if (key == 'r' || key == 'R') {
    baseMode = 1; innerMode = 1; radius = 120;
  }
  if (key == 's' || key == 'S') {
    saveFrame("week04_masked_filters-####.png");
  }
}

/* ================================
   Filter helpers (English comments)
   ================================ */

// Apply one of the supported filters to the entire image
void applyFilterToImage(PImage input, PImage out, int mode) {
  input.loadPixels();
  out.loadPixels();

  for (int i = 0; i < input.pixels.length; i++) {
    color c = input.pixels[i];
    color r;
    switch (mode) {
      case 1:  // None
        r = c; break;
      case 2:  // Invert
        r = invert(c); break;
      case 3:  // Brightness +40
        r = adjustBrightness(c, +40); break;
      case 4:  // Contrast +40 (DF Studios factor)
        r = adjustContrast(c, +40); break;
      case 5:  // Duotone (blue -> orange)
        r = duotone(c, color(20, 80, 200), color(255, 140, 40)); break;
      case 6:  // Sepia (GeeksForGeeks matrix)
        r = sepia(c); break;
      default:
        r = c;
    }
    out.pixels[i] = r;
  }
  out.updatePixels();
}

// Invert each channel
color invert(color c) {
  return color(255 - red(c), 255 - green(c), 255 - blue(c));
}

// Add brightness delta and clamp
color adjustBrightness(color c, float delta) {
  float r = constrain(red(c)   + delta, 0, 255);
  float g = constrain(green(c) + delta, 0, 255);
  float b = constrain(blue(c)  + delta, 0, 255);
  return color(r, g, b);
}

// Contrast adjustment using DF Studios formula:
// factor = (259*(c + 255)) / (255*(259 - c)), c in [-255, 255]
// new = factor*(channel - 128) + 128
color adjustContrast(color c, float contrast) {
  contrast = constrain(contrast, -255, 255);
  float factor = (259 * (contrast + 255)) / (255 * (259 - contrast));
  float r = constrain(factor * (red(c)   - 128) + 128, 0, 255);
  float g = constrain(factor * (green(c) - 128) + 128, 0, 255);
  float b = constrain(factor * (blue(c)  - 128) + 128, 0, 255);
  return color(r, g, b);
}

// Sepia tone using the classic matrix (GeeksForGeeks)
color sepia(color c) {
  float r = red(c), g = green(c), b = blue(c);
  float nr = 0.393*r + 0.769*g + 0.189*b;
  float ng = 0.349*r + 0.686*g + 0.168*b;
  float nb = 0.272*r + 0.534*g + 0.131*b;
  return color(constrain(nr, 0, 255), constrain(ng, 0, 255), constrain(nb, 0, 255));
}

// Duotone via luminance -> blend between two colours
color duotone(color c, color a, color b) {
  float r = red(c), g = green(c), b0 = blue(c);
  float lum = 0.299*r + 0.587*g + 0.114*b0; // Rec.601-ish luminance
  float t = lum / 255.0;
  return lerpColor(a, b, t);
}
