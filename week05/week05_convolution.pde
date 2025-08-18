// Week 5 — Convolution (Processing)
// Generic 3x3/5x5 kernel engine with several presets + Sobel edge detection.
//
// Keys: 1 Box blur  2 Gaussian  3 Sharpen  4 Edge  5 Emboss  6 Sobel
//       R reset to original,  S save PNG

PImage src, outImg;

void setup() {
  size(900, 600);
  pixelDensity(displayDensity());
  src = tryLoadOrMakeGradient();
  outImg = src.copy();
  noLoop();
}

void draw() {
  image(outImg, 0, 0);
  fill(0,150); noStroke();
  rect(0,0,560,64);
  fill(255);
  text("1 Box  2 Gaussian  3 Sharpen  4 Edge  5 Emboss  6 Sobel   R reset   S save", 10, 20);
}

void keyPressed() {
  if (key=='1') { outImg = convolve3x3(src, new float[]{ 1,1,1, 1,1,1, 1,1,1 }, 1.0/9.0); redraw(); }
  if (key=='2') { outImg = convolve3x3(src, new float[]{ 1,2,1, 2,4,2, 1,2,1 }, 1.0/16.0); redraw(); }
  if (key=='3') { outImg = convolve3x3(src, new float[]{ 0,-1,0, -1,5,-1, 0,-1,0 }, 1.0); redraw(); }
  if (key=='4') { outImg = convolve3x3(src, new float[]{ -1,-1,-1, -1,8,-1, -1,-1,-1 }, 1.0); redraw(); }
  if (key=='5') { outImg = convolve3x3(src, new float[]{ -2,-1,0, -1,1,1, 0,1,2 }, 1.0); redraw(); }
  if (key=='6') { outImg = sobel(src); redraw(); }

  if (key=='r'||key=='R') { outImg = src.copy(); redraw(); }
  if (key=='s'||key=='S') { saveFrame("week05_conv-####.png"); }
}

// Try to load example.jpg; fallback gradient
PImage tryLoadOrMakeGradient() {
  PImage im;
  try { im = loadImage("example.jpg"); }
  catch(Exception e) { im = null; }
  if (im == null) {
    im = createImage(width, height, RGB);
    im.loadPixels();
    for (int y=0; y<height; y++) {
      for (int x=0; x<width; x++) {
        float u = x/(float)width, v = y/(float)height;
        // Diagonal gradient + circle vignette (helps visualize edges)
        float base = lerp(40, 230, 0.85*u + 0.15*v);
        float vign = 1.0 - 0.6*constrain(dist(x,y,width*0.5,height*0.5)/(min(width,height)*0.5),0,1);
        im.pixels[x+y*width] = color(base*vign, base, base*0.9);
      }
    }
    im.updatePixels();
  } else {
    im.resize(width, height);
  }
  return im;
}

// 3x3 convolution, with clamped sampling and optional scalar multiplier
PImage convolve3x3(PImage input, float[] k, double mul) {
  PImage out = createImage(input.width, input.height, RGB);
  input.loadPixels(); out.loadPixels();
  int w = input.width, h = input.height;

  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      float sumR=0, sumG=0, sumB=0;
      int idx = 0;
      for (int j=-1; j<=1; j++) {
        for (int i=-1; i<=1; i++) {
          int sx = constrain(x+i, 0, w-1);
          int sy = constrain(y+j, 0, h-1);
          color c = input.pixels[sx + sy*w];
          float wt = k[idx++];
          sumR += red(c)   * wt;
          sumG += green(c) * wt;
          sumB += blue(c)  * wt;
        }
      }
      float r = (float)(sumR * mul);
      float g = (float)(sumG * mul);
      float b = (float)(sumB * mul);
      out.pixels[x + y*w] = color(constrain(r,0,255), constrain(g,0,255), constrain(b,0,255));
    }
  }
  out.updatePixels();
  return out;
}

// Sobel edge detection: combine |Gx| and |Gy|
PImage sobel(PImage input) {
  float[] kx = { -1,0,1, -2,0,2, -1,0,1 };
  float[] ky = { -1,-2,-1, 0,0,0, 1,2,1 };
  int w = input.width, h = input.height;
  input.loadPixels();
  PImage out = createImage(w,h,RGB); out.loadPixels();

  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      float gxR=0, gxG=0, gxB=0;
      float gyR=0, gyG=0, gyB=0;
      int idx = 0;
      for (int j=-1; j<=1; j++) {
        for (int i=-1; i<=1; i++) {
          int sx = constrain(x+i, 0, w-1);
          int sy = constrain(y+j, 0, h-1);
          color c = input.pixels[sx + sy*w];
          float wx = kx[idx];
          float wy = ky[idx];
          gxR += red(c)*wx;  gxG += green(c)*wx;  gxB += blue(c)*wx;
          gyR += red(c)*wy;  gyG += green(c)*wy;  gyB += blue(c)*wy;
          idx++;
        }
      }
      // Luma from gradient magnitude (|Gx|+|Gy| approximation)
      float r = abs(gxR)+abs(gyR);
      float g = abs(gxG)+abs(gyG);
      float b = abs(gxB)+abs(gyB);
      float lum = 0.299*r + 0.587*g + 0.114*b;
      int v = int(constrain(lum, 0, 255));
      out.pixels[x + y*w] = color(v); // grayscale
    }
  }
  out.updatePixels();
  return out;
}
