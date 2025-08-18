# Notes – Vector vs. Raster & 2D Transforms

- Vector graphics: Shapes described by geometry (points, lines, rects, ellipses, paths). Scales cleanly; operations use a transformation matrix.
- Raster graphics: Pixel grid; Scaling can cause artifacts. Weeks 1–2 focused on pixel-level processing, but this week we'll switch to vectors.
- Processing 2D Transform Core:
- `translate(x, y)`: Moves the local coordinate origin
- `rotate(a)`: Rotates by radians (around the current origin)
- `scale(s)`: Scales
- `pushMatrix()` / `popMatrix()`: Push/pop into/from the stack, encapsulating local transformations to avoid global contamination
- Artistic Style Analysis (Mondrian):
- Thick black lines + primary color blocks (red/yellow/blue) + white space.
- Unevenly sized rectangles create continuous lines and a rhythmic composition.
- I used "recursive/iterative segmentation + pseudo-random seed" to generate the composition, selected some areas to color, and used high-thick `strokeWeight` to achieve the lines.
