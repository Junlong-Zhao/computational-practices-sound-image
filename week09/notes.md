# Notes — Vectors, Forces, and Interactions

- **State = (pos, vel, acc) with PVectors.** Update rule:
  `acc += Σ(forces/mass); vel += acc; pos += vel; acc *= 0;`
- **Forces used**
  - Gravity: `g = (0, 0.4*mass)`.
  - Drag (air friction): `F_d = -c * |v| * v̂`.
  - Optional Attractor: `F = G*m / (r²) * r̂` (clamped).
  - Mouse gust: an impulse applied on click (instantaneous change of `vel`).
- **Collisions**: wall bounce with restitution `e`:
  `vel *= -e` on the axis where wall is hit.
- **Design choices**
  - Keep the physics stable via small constants and clamped magnitudes.
  - Game loops at default `frameRate`, using PVectors for clarity.
