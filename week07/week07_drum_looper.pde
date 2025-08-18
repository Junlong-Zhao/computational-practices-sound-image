// Week 7 — Algorithmic Drum Looper (Processing + Sound library)
// Uses four samples (kick/snare/hat/clap) scheduled via the modulo operator.
// >= 4 samples ✔  pattern changes over time ✔  optional synth layer ✔
//
// Put WAVs in data/: kick.wav, snare.wav, hat.wav, clap.wav
// Controls: SPACE start/stop | UP/DOWN BPM | R re-roll fills | V visualiser | O synth | S save

import processing.sound.*;

final int STEPS = 16;        // 16th notes per bar
int bpm = 100;               // tempo
float stepMs;                // ms per step
boolean running = false;
long t0;                     // loop start time (millis)
int lastStep = -1;
int barCount = 0;

// --- SoundFiles (disk-based). For ultra-low latency you could switch to AudioSample (RAM-based). ---
// Docs: SoundFile — https://processing.org/reference/libraries/sound/SoundFile.html
//       AudioSample — https://processing.org/reference/libraries/sound/AudioSample.html
SoundFile kick1, kick2;   // two voices to avoid retrigger cut-offs
SoundFile snare1, snare2;
SoundFile hat1, hat2;
SoundFile clap1;

// tiny round-robin player helper
class Player {
  SoundFile[] pool; int idx=0;
  Player(SoundFile... f){ pool = f; }
  void trig(float gain){
    SoundFile s = pool[idx];
    s.amp(constrain(gain, 0, 1));
    s.play();             // one-shot
    idx = (idx + 1) % pool.length;
  }
}
Player K, S, H, C;

// Optional: synthesis layer (combines Week 6 with samples)
SinOsc bass; Env env;
boolean useSynth = true;

// Probability maps for evolving fills (re-rolled over time)
boolean[] hatFill = new boolean[STEPS];
boolean[] snrFill = new boolean[STEPS];

boolean showViz = true;

void settings(){ size(980, 420); }

void setup() {
  background(10);
  textFont(createFont("Arial", 14));

  // Load samples (one-shots). Any short WAVs are fine.
  kick1  = new SoundFile(this, "kick.wav");
  kick2  = new SoundFile(this, "kick.wav");
  snare1 = new SoundFile(this, "snare.wav");
  snare2 = new SoundFile(this, "snare.wav");
  hat1   = new SoundFile(this, "hat.wav");
  hat2   = new SoundFile(this, "hat.wav");
  clap1  = new SoundFile(this, "clap.wav");

  K = new Player(kick1, kick2);
  S = new Player(snare1, snare2);
  H = new Player(hat1, hat2);
  C = new Player(clap1);

  // Synth bass (short ping on downbeats)
  bass = new SinOsc(this);
  env  = new Env(this);
  bass.amp(0.8); // envelope shapes actual loudness

  recalcStepMs();
  rerollFills();
}

void draw() {
  background(8);

  if (running) {
    int step = currentStep();
    if (step != lastStep) {
      // step edge detected
      if (step == 0) {
        barCount++;
        if (barCount % 4 == 0) rerollFills();   // evolve fills every 4 bars
      }
      triggerStep(step);
      lastStep = step;
    }
  }

  // HUD
  fill(0, 160); noStroke(); rect(0, 0, width, 58);
  fill(255);
  text("BPM: " + bpm + "   Running: " + running +
       "   Bar: " + barCount + "   STEP: " + (lastStep<0 ? "-" : lastStep) +
       "   [SPACE start/stop]  ↑/↓ BPM  R re-roll  V visualiser  O synth  S save", 12, 24);

  if (showViz) drawVisualizer();
}

// --- CORE: schedule decision for one step (uses modulo logic everywhere) ---
void triggerStep(int s) {
  // A/B structure toggles every 2 bars -> different probabilities
  boolean B = ((barCount/2) % 2 == 1);

  // ----- KICK -----
  // strong downbeats
  if (s == 0 || s == 8) K.trig(1.0);
  // groove variations
  if (s == 4 && (B || random(1) < 0.65))  K.trig(0.85);
  if (s == 12 && (B || random(1) < 0.75)) K.trig(0.9);
  // ghost kicks near the end
  if ((s == 11 || s == 15) && random(1) < 0.15) K.trig(0.5);

  // ----- SNARE -----
  // backbeat
  if (s == 4 || s == 12) {
    S.trig(1.0);
    if (s == 12) C.trig(0.7);   // clap layered on 12
  }
  // micro-fills
  if (snrFill[s]) S.trig(0.5);

  // ----- HI-HATS -----
  // eighths on even steps, accents every 4
  if (s % 2 == 0) {
    float v = (s % 4 == 0) ? 0.9 : 0.6;
    H.trig(v);
  }
  if (hatFill[s]) H.trig(0.95); // extra “open-hat-ish” hit

  // ----- SYNTH BASS (optional) -----
  if (useSynth && (s == 0 || s == 8)) {
    // slight pitch drift with BPM keeps things lively
    float base = (s==0 ? 55.0 : 41.2);         // A1 -> E1
    float drift = pow(2, (bpm-100)/48.0);
    bass.freq(base * drift);
    env.play(bass, 0.005, 0.22, 0.45, 0.18);   // attack, sustainTime, sustainLevel, release
  }
}

// current step index via time -> modulo
int currentStep() {
  float elapsed = millis() - t0;
  if (elapsed < 0) return 0;
  return floor(elapsed / stepMs) % STEPS;
}

void startLoop(){ t0 = millis(); lastStep = -1; running = true; }
void stopLoop(){ running = false; }
void recalcStepMs(){ stepMs = 60000.0 / (bpm * 4.0); }

// fill maps get more probability near the end of bar
void rerollFills() {
  for (int i=0; i<STEPS; i++) {
    float pos = i/16.0;
    float w = 0.05 + 0.35*pow(max(0, pos-0.6)/0.4, 1.2); // ramp up after 60% of bar
    hatFill[i] = (random(1) < w) && (i%2==1);          // off-beat preference
    snrFill[i] = (random(1) < w*0.6) && (i%2==1);
  }
}

// simple grid visualiser
void drawVisualizer() {
  float pad = 24, gridW = width - 2*pad, cellW = gridW / STEPS, y = height*0.72;
  stroke(255, 60); strokeWeight(1);
  for (int i=0;i<STEPS;i++) {
    float x = pad + i*cellW;
    noFill();
    rect(x, y, cellW-4, 60);

    if (i == lastStep) { noStroke(); fill(60, 180, 255, 180); rect(x, y, cellW-4, 60); stroke(255,60); }
    if (hatFill[i]) { noStroke(); fill(255, 220, 0, 150); rect(x+4, y+4,  cellW-12, 12); stroke(255,60); }
    if (snrFill[i]) { noStroke(); fill(255, 120, 120,150); rect(x+4, y+22, cellW-12, 12); stroke(255,60); }
  }
}

void keyPressed() {
  if (key == ' ') { if (running) stopLoop(); else startLoop(); }
  if (keyCode == UP)   { bpm = min(220, bpm+2); recalcStepMs(); }
  if (keyCode == DOWN) { bpm = max( 60, bpm-2); recalcStepMs(); }
  if (key == 'r' || key == 'R') rerollFills();
  if (key == 'v' || key == 'V') showViz = !showViz;
  if (key == 'o' || key == 'O') useSynth = !useSynth;
  if (key == 's' || key == 'S') saveFrame("week07_drum-####.png");
}
