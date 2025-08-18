// Week 5 — Dithering (Processing)
// Modes: Threshold, Ordered Bayer (4x4), Floyd–Steinberg error diffusion
// Keys: 1 Threshold, 2 Ordered(Bayer), 3 Floyd–Steinberg,
//       C toggle clipping preview, L reload original, S save result.
//
// References used:
// - Lucas Pope on Return of the Obra Dinn dithering (video + forum)
// - Surma: Ditherpunk
// - Tanner Helland: Dithering algorithms and code

PImage src;          // original image
PImage work;         // working buffer
int mode = 2;        // default: Ordered
boolean clipPreview = true;

void setup() {
  size(900, 600);
  pixelDensity(displayDensity());
  src = tryLoadOrMakeGradient();
  work = createImage(src.width, src.height, RGB);
  redrawAll();
  noLoop();
}

void draw() {
  image(work, 0, 0);
  // HUD
  fill(0, 150); noStroke();
  rect(0, 0, 560, 64);
  fill(255);
  text("Mode: " + modeName() + "    C: clip-preview " + clipPreview +
       "    L: reload   S: save", 10, 20);
  text("1 Threshold   2 Ordered(Bayer 4x4)   3 Floyd–Steinberg  (1-bit palette)", 10, 40);
}

String modeName() {
  if (mode==1) return "Threshold";
  if (mode==2) return "Ordered (Bayer 4x4)";
  if (mode==3) return "Floyd–Steinberg";
  return "Unknown";
}

void keyPressed() {
  if (key=='1') { mode = 1; redrawAll(); }
  if (key=='2') { mode = 2; redrawAll(); }
  if (key=='3') { mode = 3; redrawAll(); }
  if (key=='c'||key=='C') { clipPreview = !clipPreview; redraw(); }
  if (key=='l'||key=='L') { src = tryLoadOrMakeGradient(); redrawAll(); }
  if (key=='s'||key=='S') { saveFrame("week05_dither-####.png"); }
}

void redrawAll() {
  if (mode==1) work = ditherThreshold(src, 128);
  if (mode==2) work = ditherOrderedBayer(src);
  if (mode==3) work = ditherFloydSteinberg(src);
  redraw();
}

// Try to load example.jpg; fallback generate a gradient test card
PImage tryLoadOrMakeGradient() {
  PImage im;
  try { im = loadImage("example.jpg"); }
  catch(Exception e) { im = null; }
  if (im == null) {
    im = createImage(width, height, RGB);
    im.loadPixels();
    for (int y=0; y<height; y++) {
      for (int x=0; x<width; x++) {
        float tx = x/(float)width;
        float ty = y/(float)height;
        color a = color(30, 30, 30);
        color b = color(240, 240, 240);
        im.pixels[x + y*width] = lerpColor(lerpColor(a,b,tx), color(240,200,150), 0.2*ty);
      }
    }
    im.updatePixels();
  } else {
    im.resize(width, height);
  }
  return im;
}

// ---------- Dithering Pipelines ----------

// Baseline: global threshold to 1-bit
PImage ditherThreshold(PImage input, int thr) {
  PImage out = createImage(input.width, input.height, RGB);
  input.loadPixels(); out.loadPixels();
  for (int i=0; i<input.pixels.length; i++) {
    color c = input.pixels[i];
    float lum = 0.299*red(c) + 0.587*green(c) + 0.114*blue(c);
    out.pixels[i] = (lum > thr) ? color(255) : color(0);
  }
  out.updatePixels();
  return out;
}

// Ordered dithering using 4x4 Bayer matrix
PImage ditherOrderedBayer(PImage input) {
  int[][] bayer4 = {
    { 0,  8,  2, 10},
    {12,  4, 14,  6},
    { 3, 11,  1,  9},
    {15,  7, 13,  5}
  };
  // Normalize to [0,1) by (n+0.5)/16 — classic trick to reduce bias
  PImage out = createImage(input.width, input.height, RGB);
  input.loadPixels(); out.loadPixels();
  for (int y=0; y<input.height; y++) {
    for (int x=0; x<input.width; x++) {
      int i = x + y*input.width;
      color c = input.pixels[i];
      float lum = (0.299*red(c) + 0.587*green(c) + 0.114*blue(c)) / 255.0;
      float t = (bayer4[y&3][x&3] + 0.5) / 16.0;
      float v = clipPreview ? lum : constrain(lum, 0, 1);
      out.pixels[i] = (v > t) ? color(255) : color(0);
    }
  }
  out.updatePixels();
  return out;
}

// Floyd–Steinberg (error diffusion) to 1-bit palette {0,255}
PImage ditherFloydSteinberg(PImage input) {
  PImage out = input.copy();
  out.loadPixels();

  // Work on luminance buffer for accuracy, then write 0/255
  int w = out.width, h = out.height;
  float[] lum = new float[w*h];
  for (int i=0; i<w*h; i++) {
    color c = out.pixels[i];
    lum[i] = 0.299*red(c) + 0.587*green(c) + 0.114*blue(c);
  }

  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      int i = x + y*w;
      float old = lum[i];
      float newc = (old >= 128) ? 255 : 0;
      float err = old - newc;
      lum[i] = newc; // quantized

      // Distribute error to neighbors (serpentine optional; here left->right)
      if (x+1 < w)       lum[i+1]       += err * 7/16.0;
      if (y+1 < h) {
        if (x-1 >= 0)    lum[i-1 + w]   += err * 3/16.0;
                         lum[i   + w]   += err * 5/16.0;
        if (x+1 < w)     lum[i+1 + w]   += err * 1/16.0;
      }
    }
  }

  for (int i=0; i<w*h; i++) {
    float v = clipPreview ? lum[i] : constrain(lum[i], 0, 255);
    out.pixels[i] = (v >= 128) ? color(255) : color(0);
  }
  out.updatePixels();
  return out;
}
