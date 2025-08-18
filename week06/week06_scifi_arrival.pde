// Week 6 — Sci-Fi "Planet Landing" sound
// Uses three oscillators (Sin/Saw/Tri), envelopes, and time-varying frequency.
// Keys: SPACE trigger, LEFT/RIGHT global pitch shift, S save a frame.

import processing.sound.*;

SinOsc bass;     // low rumble
SawOsc sweep;    // bright spectral sweep
TriOsc lead;     // mid-range tone for presence

Env envBass, envSweep, envLead;

boolean playing = false;
float t0 = 0;              // start time (seconds) of the event
float pitchShift = 0;      // semitones, controlled by arrow keys

// Utility: semitone shift -> frequency ratio
float ratio(float semis){ return pow(2.0, semis/12.0); }

void setup() {
  size(900, 300);
  background(12);
  textFont(createFont("Arial", 14));

  // Instantiate oscillators
  bass  = new SinOsc(this);
  sweep = new SawOsc(this);
  lead  = new TriOsc(this);

  // Envelopes
  envBass  = new Env(this);
  envSweep = new Env(this);
  envLead  = new Env(this);

  // Pre-set amplitudes (actual loudness is shaped by envelopes)
  bass.amp(0.8);
  sweep.amp(0.5);
  lead.amp(0.35);

  noLoop();
}

void draw() {
  background(18);
  fill(255);
  text("Sci-Fi landing — press SPACE to trigger   ←/→ pitch shift: "
       + nf(pitchShift,1,1) + " semitones   S save", 12, 22);

  if (playing) {
    float t = (millis()/1000.0) - t0;

    // ---- Bass rumble: slow upward sweep + tiny vibrato ----
    // Base 48 Hz → 70 Hz over 3.5 s (ease-in-out)
    float bassBase = 48 * ratio(pitchShift);
    float bassTarget = 70 * ratio(pitchShift);
    float u = constrain(t/3.5, 0, 1);
    float ease = (3*u*u - 2*u*u*u);           // smoothstep
    float bassFreq = lerp(bassBase, bassTarget, ease);
    bassFreq += 1.5 * sin(TWO_PI * 2.0 * t);  // 2 Hz vibrato
    bass.freq(max(20, bassFreq));

    // ---- Sweep: wide spectral rise then fall ----
    // 300 Hz → 2200 Hz (1.6 s), then decay to 600 Hz (next 1.2 s)
    float s;
    if (t < 1.6) {
      s = map(t, 0, 1.6, 300, 2200);
    } else {
      s = map(constrain(t, 1.6, 2.8), 1.6, 2.8, 2200, 600);
    }
    s *= ratio(pitchShift);
    s += 12 * sin(TWO_PI * 6.0 * t);          // light vibrato
    sweep.freq(s);

    // ---- Lead: a short beacon-like ping sequence ----
    // Triggered via envelope steps (see keyPressed)
    // Here we just animate slight vibrato while it sustains.
    lead.freq( 880 * ratio(pitchShift) + 15 * sin(TWO_PI * 5.5 * t) );

    // Stop logic: finish after ~4.5 s
    if (t > 4.5) playing = false;
  }

  // Simple progress bar during the event
  if (playing) {
    float p = constrain(((millis()/1000.0)-t0) / 4.5, 0, 1);
    noStroke(); fill(60,180,255); rect(0, height-10, width*p, 10);
  }
}

void triggerLanding() {
  t0 = millis()/1000.0;
  playing = true;

  // Set starting freqs before envelopes play
  bass.freq(48 * ratio(pitchShift));
  sweep.freq(300 * ratio(pitchShift));
  lead.freq(880 * ratio(pitchShift));

  // ADSR-like envelopes (attack, sustainTime, sustainLevel, release)
  envBass.play( bass,  0.60, 3.00, 0.55, 1.10 );   // slow ramp up, long body
  envSweep.play(sweep, 0.08, 1.35, 0.65, 0.70 );   // fast attack bright sweep
  envLead.play( lead,  0.01, 0.18, 0.35, 0.25 );   // short ping

  // Schedule two extra lead pings (beacon beeps)
  new java.util.Timer().schedule(new java.util.TimerTask(){ public void run(){
    envLead.play(lead, 0.005, 0.12, 0.32, 0.20);
  }}, 420); // in 0.42 s
  new java.util.Timer().schedule(new java.util.TimerTask(){ public void run(){
    envLead.play(lead, 0.005, 0.12, 0.32, 0.20);
  }}, 780); // in 0.78 s

  redraw();
}

void keyPressed() {
  if (key == ' ') { triggerLanding(); }
  if (keyCode == LEFT)  { pitchShift -= 1; redraw(); }
  if (keyCode == RIGHT) { pitchShift += 1; redraw(); }
  if (key == 's' || key == 'S') { saveFrame("week06_scifi-####.png"); }
}
