# Week 7 — Algorithmic Music & Sampling

## What I did
- Loaded **four drum samples** (`kick/snare/hat/clap`) with `SoundFile` and scheduled them using the **modulo operator** to build a 16-step sequencer.
- The groove **changes over time**:
  - A/B bar structure alternates every 2 bars,
  - probability-driven micro-fills on the last quarter of each bar,
  - velocity accents and occasional ghost notes.
- Optional **synth bass** (SinOsc) to combine synthesis with samples.
- Small **visualiser** shows the step grid and live highlights.

## Controls
- `SPACE` start/stop  •  `↑/↓` BPM ±2  •  `R` re-roll fills  •  `V` toggle visualiser  
- `O` toggle synth bass  •  `S` save a frame

## Files
- `week07_drum_looper.pde`

## Samples (put these WAVs in `data/`)
- `kick.wav`, `snare.wav`, `hat.wav`, `clap.wav`  (short one-shots; 44.1kHz/16-bit recommended)

## Demo video
[Week7-Algorithmic Drum Looper](./Week7-Algorithmic%20Drum%20Looper.mp4)

Google Drive:
- [Week7-Algorithmic Drum Looper](https://drive.google.com/file/d/1QIkJP71RcDDFu0LSO1PkZyHbZt2fkrg3/view?usp=drive_link)

## Resources used 
- Processing **SoundFile** docs — https://processing.org/reference/libraries/sound/SoundFile.html
- Processing **AudioSample** docs (low-latency RAM-loaded samples; optional alternative) — https://processing.org/reference/libraries/sound/AudioSample.html
- Free samples — https://freesound.org/
- Essential hip-hop drum patterns (timing ideas) — https://midimighty.com/blogs/resources/hip-hop-drum-patterns-essential-hiphop
