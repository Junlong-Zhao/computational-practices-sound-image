# Notes — Modulo scheduling & evolving patterns

- **Step scheduling with modulo**  
  With 16 steps per bar at `BPM`, the 16th duration is `stepMs = 60000 / (BPM * 4)`.  
  Current step = `floor((millis() - t0) / stepMs) % 16`.  
  Bars are counted by detecting when step rolls over to 0.

- **Patterns (baseline)**  
  Kick on 0/8 (downbeats), optional on 4/12; backbeat snare on 4/12; hats on even steps with accents every 4; clap layered on 12.

- **Time-varying change**  
  A/B structure switches every 2 bars; probability maps for hats/snare fills are **re-rolled every 4 bars** (more likely in the last quarter of the bar).

- **Velocity accents**  
  Hats accent every 4th step; kicks on 0/8 are louder. Ghost notes have lower velocity.

- **Synthesis + samples**  
  A short SinOsc bass ping on 0/8 with an envelope (from Week 6 idea).  
  If extremely low latency retrigger is required, `AudioSample` (RAM-based) can replace `SoundFile` (see official docs).
