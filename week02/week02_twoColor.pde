PImage img;
color color1 = color(0);     
color color2 = color(255);   
float threshold = 127;       

void setup() {
  size(400, 400);
  img = loadImage("example.jpg");
  img.resize(width, height);
  image(img, 0, 0);
  
  loadPixels();
  img.loadPixels();
  
  for (int i = 0; i < pixels.length; i++) {
    float b = brightness(img.pixels[i]);
    if (b > threshold) {
      pixels[i] = color1;
    } else {
      pixels[i] = color2;
    }
  }
  updatePixels();
}
