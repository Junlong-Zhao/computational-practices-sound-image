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
      if (x < width/2) {
        pixels[i] = c;
      } else {
        pixels[i] = color(255 - red(c), 255 - green(c), 255 - blue(c));
      }
    }
  }
  updatePixels();
}
