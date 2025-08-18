// Week 2 — Two-Color threshold (robust version)
// Put "example.jpg" in the sketch's data/ folder, or a fallback gradient will be used.

PImage img, out;
color color1 = color(0);     // black
color color2 = color(255);   // white
float threshold = 127;       // 0..255

void setup() {
  size(400, 400);
  pixelDensity(1);                 // avoid HiDPI pixel-length mismatches

  img = loadImage("example.jpg");  // must be in data/ folder
  if (img == null) {
    // fallback: make a gradient so the sketch still runs
    img = makeFallback(width, height);
  }
  img.resize(width, height);

  out = createImage(width, height, RGB);

  // Process pixels into a new image (safer than touching the window pixels[])
  img.loadPixels();
  out.loadPixels();
  for (int i = 0; i < out.pixels.length; i++) {
    color c = img.pixels[i];

    // compute luminance (perceptual) rather than relying on brightness()
    float r = red(c), g = green(c), b = blue(c);
    float lum = 0.299*r + 0.587*g + 0.114*b;

    // NOTE: your original code mapped bright -> black; keep that behaviour:
    // if you want "bright -> white", just swap color1 and color2 below.
    out.pixels[i] = (lum > threshold) ? color1 : color2;
  }
  out.updatePixels();

  image(out, 0, 0);
  noLoop();  // we render once in setup
}

PImage makeFallback(int w, int h) {
  PImage im = createImage(w, h, RGB);
  im.loadPixels();
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      float u = x/(float)w, v = y/(float)h;
      im.pixels[x + y*w] = lerpColor(color(240,220,220), color(40,40,60), (u+v)*0.5);
    }
  }
  im.updatePixels();
  return im;
}
