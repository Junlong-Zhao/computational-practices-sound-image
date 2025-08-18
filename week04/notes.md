# Notes — Week 4: Noise, Filters, Masking

## Perlin Noise
- `noise()` creates smooth, coherent values (continuous in x/y/t), unlike `random()` which is uncorrelated. 
- Useful to generate natural textures and motion. I animated noise over z-time to show evolving patterns.

## Filters (pixel manipulation)
- Work on a 1-D pixel array; index is `i = x + y*width`.
- Luminance (for threshold/duotone): `lum = 0.299*R + 0.587*G + 0.114*B`.
- Brightness: add delta and clamp to [0,255].
- **Contrast** uses the DF Studios factor  
  `factor = (259*(c + 255)) / (255*(259 - c))`, with `c in [-255, 255]`,  
  then `new = factor*(channel-128)+128` (clamp).
- **Sepia** (GeeksForGeeks matrix):  
  `R' = .393R + .769G + .189B`  
  `G' = .349R + .686G + .168B`  
  `B' = .272R + .534G + .131B` (clamp).
- **Duotone**: map luminance to [0,1], then blend two colours with `lerpColor`.

## Masking
- Circular mask around the mouse: if `dist(x, y, mouseX, mouseY) < radius`, apply the “inner” filter; otherwise apply the “base” filter.
- This demonstrates selective processing with user interaction.
