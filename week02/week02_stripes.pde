PImage img;

void setup() {
  size(400, 400);
  img = loadImage("example.jpg");
  img.resize(width, height);
  image(img, 0, 0);
  
  loadPixels();
  img.loadPixels();
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int i = x + y * width;
      color c = img.pixels[i];
      if (y % 2 == 0) { // 偶数行亮度增加
        pixels[i] = color(min(red(c)+50,255), min(green(c)+50,255), min(blue(c)+50,255));
      } else {
        pixels[i] = c;
      }
    }
  }
  updatePixels();
}
