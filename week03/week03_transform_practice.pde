// Week 3 – Transform practice (translate / rotate / scale / push-pop)
void setup() {
  size(600, 420);
  noLoop();
  smooth(8);
  background(245);
  stroke(30);
  fill(255, 220);
}

// 画 n 边形的小工具
void polygon(float r, int n) {
  beginShape();
  for (int i = 0; i < n; i++) {
    float a = TWO_PI * i / n - HALF_PI;
    vertex(cos(a) * r, sin(a) * r);
  }
  endShape(CLOSE);
}

void draw() {
  // 一排旋转矩形
  rectMode(CENTER);
  for (int i = 0; i < 8; i++) {
    pushMatrix();
    translate(60 + i * 65, height * 0.27);
    rotate(radians(i * 6));   // Increase the rotation angle one by one
    fill(200, 230, 255, 200);
    rect(0, 0, 50, 22);
    popMatrix();
  }

  // 不同缩放的多边形
  for (int i = 0; i < 5; i++) {
    pushMatrix();
    translate(80 + i * 105, height * 0.7);
    scale(0.6 + 0.25 * i);
    fill(255, 240, 200, 220);
    polygon(30, 5 + i);       // From pentagon to enneagon
    popMatrix();
  }

  // Combination: Translate to the center and rotate a "windmill"
  pushMatrix();
  translate(width * 0.8, height * 0.5);
  for (int k = 0; k < 8; k++) {
    pushMatrix();
    rotate(k * PI / 4.0);
    fill(220, 255, 220, 200);
    rect(50, 0, 70, 12);
    popMatrix();
  }
  popMatrix();
}
