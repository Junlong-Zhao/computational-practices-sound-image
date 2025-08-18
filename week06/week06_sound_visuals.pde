// Week 6 — Sound-Reactive Visualization driven by oscillators
// Keys: 1 analyse Sin, 2 analyse Saw, 3 analyse Tri,  A toggle auto-sweep,  S save

import processing.sound.*;

SinOsc sin;   SawOsc saw;   TriOsc tri;
Amplitude amp;              // amplitude analyser for the selected oscillator
int current = 1;            // 1=sin, 2=saw, 3=tri
boolean autoSweep = true;   // automatically sweep frequency for visuals

float baseSin = 220, baseSaw = 330, baseTri = 550;
float t0;

void setup() {
  size(900, 540);
  background(10);
  textFont(createFont("Arial", 14));

  sin = new SinOsc(this);   sin.amp(0.25);  sin.freq(baseSin);  sin.play();
  saw = new SawOsc(this);   saw.amp(0.18);  saw.freq(baseSaw);  saw.play();
  tri = new TriOsc(this);   tri.amp(0.20);  tri.freq(baseTri);  tri.play();

  amp = new Amplitude(this);
  amp.input(sin);           // default analyse sin

  t0 = millis()/1000.0;
}

void draw() {
  float t = millis()/1000.0 - t0;

  // Optional auto-sweep to make visuals react
  if (autoSweep) {
    sin.freq( baseSin + 60 * sin(TWO_PI * 0.12 * t) );
    saw.freq( baseSaw + 90 * sin(TWO_PI * 0.08 * t + 1.3) );
    tri.freq( baseTri + 40 * sin(TWO_PI * 0.16 * t + 2.2) );
  }

  float level = amp.analyze();             // 0..~1 amplitude
  float freq  = current==1 ? baseSin : current==2 ? baseSaw : baseTri;

  // Map level+freq to colours and sizes
  float r = map(level, 0, 0.3, 40, 255);
  float g = map(level, 0, 0.3, 180, 255);
  float b = map(freq,  150, 800, 150, 255);

  noStroke();
  fill(0, 26); rect(0,0,width,height);     // slight trail (motion blur)

  // Central reactive circle
  float rad = map(level, 0, 0.35, 80, 280);
  fill(r, g, b, 220);
  ellipse(width*0.5, height*0.55, rad*2, rad*2);

  // Radial spikes (count changes with frequency)
  int spikes = int(map(freq, 150, 800, 10, 36));
  stroke(255, 220); strokeWeight(2);
  pushMatrix();
  translate(width*0.5, height*0.55);
  float base = rad + 40;
  for (int i=0; i<spikes; i++) {
    float a = TWO_PI * i/spikes + t*0.7;
    float len = base + 120 * pow(level, 0.6) * (0.5 + 0.5*sin(a*3.0 + t*2.0));
    line(cos(a)*base, sin(a)*base, cos(a)*len, sin(a)*len);
  }
  popMatrix();

  // HUD
  fill(0,150); noStroke(); rect(0,0,600,58);
  fill(255);
  text("Analysing: " + (current==1? "Sin" : current==2? "Saw" : "Tri") +
       "   Level: " + nf(level,1,3) + "   Auto-sweep: " + autoSweep +
       "   Keys: 1/2/3 switch  A toggle  S save", 12, 20);
}

void keyPressed() {
  if (key=='1') { amp.input(sin); current=1; }
  if (key=='2') { amp.input(saw); current=2; }
  if (key=='3') { amp.input(tri); current=3; }
  if (key=='a'||key=='A') { autoSweep = !autoSweep; }
  if (key=='s'||key=='S') { saveFrame("week06_visuals-####.png"); }
}
