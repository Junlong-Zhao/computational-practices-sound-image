# Week 9 — Vectors and Motion

## What I did
- Reviewed vector motion with `PVector` (position/velocity/acceleration) and the modulo update loop.
- **Hr2**: Extended the classic bouncing ball — click near the ball to add an impulse (“mouse bounce”), with gravity and wall restitution.
- **Hr3**: Built a small game **“Flower Glide”** that uses:
  - at least **1 class** (`Player`, `Flower`)
  - at least **2 forces** influencing motion (**gravity** + **drag**; optional **attractor/wind gust**)
  - at least **1 interaction** (keyboard thrust, **mouse gust**)
  - scoring and end conditions.

## Controls
### Bouncing ball
- Click near the ball → adds an upward/away impulse
- `S` save frame

### Game — *Flower Glide*
- `←/→` horizontal thrust, `SPACE` short boost
- **Mouse click**: wind gust from mouse (pushes the player)
- `E` toggle attractor on/off, `R` reset, `S` save frame
- Collect all flowers before falling out-of-bounds

## Files
- `week09_bouncing_ball.pde`
- `week09_vector_game.pde`

## Resources used (given in the brief)
- Nature of Code (vectors): https://natureofcode.com/vectors/
- The Coding Train (vectors playlist)
- Processing `PVector` reference: https://processing.org/reference/PVector.html
- `mouseClicked()`: https://processing.org/reference/mouseClicked_.html
- `keyPressed()`: https://processing.org/reference/keyPressed_.html
