# computational-practices-sound-image
Computational Practices: Sound and Image Processing
# Computational Practices: Sound & Image Processing — Weeks 1–9 (no Week 8)
> **Environment:** Processing 4.x (Java mode).  
> **Audio:** install **Sound** → `Sketch → Import Library… → Add Library… → search "Sound"`.  
> **Run:** open each week’s `.pde` in Processing and press ▶︎.
## Repository layout
week01/ Getting started, pixels & colour
week02/ Pixel manipulation lab (threshold/stripes/checkerboard/half-invert)
week03/ Vector graphics (artist study + 2D transforms)
week04/ Noise + image filters + mouse mask
week05/ Dithering (Threshold / Bayer 4×4 / Floyd–Steinberg) + Convolution kernels
week06/ Oscillators & sound visualisation (Sound library)
week07/ Algorithmic music with samples (drum looper)
week09/ Vectors & motion: bouncing ball + mini game “Flower Glide”

---

## Week 1 — Pixels & Colour
**What:** repo setup, Processing warm-ups, gradients/pixels basics.  
**Files:** `week01/README.md`, `week01/example_gradient.pde` (or your W1 sketch).  
**Notes:** if `saveFrame()` is used, exported images go to a folder like `week01/frames/`.

---

## Week 2 — Manipulating & Analysing Pixels
**What:** four pixel filters/constraints:
1. **Two-Color** (threshold)  
2. **Stripe Makers** (every other row brighter)  
3. **Checkerboard Creators** (modify alternating cells)  
4. **Half/Half** (half inverted)

**File:** `week02/week02_pixel_lab.pde`  
**Controls:** `1` Threshold, `2` Stripes, `3` Checkerboard, `4` Half-invert.  
*(Optional)* `O` open image, `S` save output.

---

## Week 3 — Vector Graphics
**What:** vector primitives + `push/pop + translate/rotate/scale`; homage to modern artists (Kandinsky/Mondrian style).  
**Files:**
- `week03/week03_mondrian.pde` (grid, thick black strokes, primary colours)  
- `week03/week03_shapes_transform.pde` (polygons, petals, star/arms)

**Controls:** `S` save; `1/2/3` switch layouts (if provided).

---

## Week 4 — Filtering Images (+ Mask)
**What:**
- **Hr1:** Perlin Noise exploration.  
- **Hr2:** brightness/contrast/invert/duotone/threshold filters.  
- **Hr3:** **mouse circular mask** using `dist()` → different filters inside vs. outside.

**Files:**  
- `week04/week04_noise_filters.pde`  
- `week04/week04_masking.pde`

**Typical controls:** `1` Threshold, `2` Brightness, `3` Contrast, `4` Invert, `5` Duotone; mouse moves mask centre; `S` save.

---

## Week 5 — Dithering & Convolution
**What:**
- Dithering: **Threshold / Bayer 4×4 / Floyd–Steinberg** (error diffusion).  
- Convolution: **Box / Gaussian / Sharpen / Edge / Emboss / Sobel** kernels.

**Files:**  
- `week05/week05_dithering.pde`  
- `week05/week05_convolution.pde`

**Controls:**  
- **Dither:** `1` Threshold, `2` Bayer 4×4, `3` Floyd–Steinberg; `L` reload, `S` save.  
- **Convolution:** `1` Box, `2` Gaussian, `3` Sharpen, `4` Edge, `5` Emboss, `6` Sobel; `R` reset, `S` save.

---

## Week 6 — Digital Sound & Oscillation
**What:** Sound library; **Sin/Tri/Saw** oscillators; map amplitude/frequency to **audio-reactive visuals**.  
**Files:**
- `week06/week06_osc_demo.pde` (multiple oscillators / envelopes / modulation)
- `week06/week06_visualiser.pde` (waveform, radial bars, etc.)

**Controls:** `1/2/3` waveform, `A/Z` frequency, `[`/`]` volume or envelope, `S` save.  
**Note:** install **Sound**; mind output volume.

---

## Week 7 — Algorithmic Music & Sampling
**What:** at least **4 samples** (kick/snare/hat/clap); **16-step drum looper**; A/B pattern evolution, probability fills, accents/ghost notes; optional synth bass (SinOsc + `Env`).  
**Files & data:**
- `week07/week07_drum_looper.pde`
- **Samples in `week07/data/`:** `kick.wav`, `snare.wav`, `hat.wav`, `clap.wav` (44.1k/16-bit recommended)

**Controls:** `SPACE` start/stop, `↑/↓` BPM, `R` roll/fill, `O` toggle bass, `V` visualiser, `S` save.

---

## Week 8 — Hackathon
Attended the Hackathon — **no separate weekly submission**.

---

## Week 9 — Vectors & Motion
### Hr2 — Bouncing Ball (vectors + forces + collision)
**File:** `week09/week09_bouncing_ball.pde`  
**Forces:** gravity + quadratic air drag; wall collisions with restitution.  
**Interaction:** click near the ball to add an impulse (“mouse bounce”).  
**Control:** `S` save.

### Hr3 — Mini Game: “Flower Glide”
**File:** `week09/week09_vector_game.pde`  
**Meets brief:**  
- **≥1 class:** `Player`, `Flower`  
- **≥2 forces:** gravity + drag (plus optional attractor/wind)  
- **≥1 interaction:** keyboard thrust + mouse gust  
**Goal:** collect 10 flowers; falling out of bounds = fail.  
**Controls:** `←/→` thrust, `SPACE` short boost, mouse click gust, `E` attractor toggle, `R` reset, `S` save.

---

## Screenshots / Demos
Add a `screenshot.png` or short GIF/video in each `weekXX/` for quick review (optional but recommended).

---

## References (selection)
- **Nature of Code** (Vectors / Forces / Particles)  
- **The Coding Train** (Vectors & Forces series)  
- Image filtering notes (brightness/contrast/sepia principles)  
- **Processing Sound** reference; **freesound.org** for samples  

---

## Final checklist before submission
- [ ] Processing 4.x; **Sound** installed (Weeks 6–7)  
- [ ] Week 7 samples are in `week07/data/` with matching filenames  
- [ ] Every `.pde` runs; `S` saves a frame where implemented  
- [ ] This README matches folder content; per-week comments live in code

