// Week 1: Pixels and Colour Example
PImage img;

void setup() {
  size(400, 400);                 
  img = loadImage("example.jpg"); 
  image(img, 0, 0, width, height);
}

void draw() {
  loadPixels();                   
  for (int i = 0; i < pixels.length; i++) {
    color c = pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    // 生成反色效果
    pixels[i] = color(255-r, 255-g, 255-b);
  }
  updatePixels();                 
  noLoop();                       
}
