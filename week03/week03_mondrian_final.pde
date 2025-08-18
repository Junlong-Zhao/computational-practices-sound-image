// Week 3 – Mondrian-style composition (final)
// Keys:  R -> recompose (new seed),  S -> save PNG,  +/- -> adjust minimum block size

class Cell {
  float x, y, w, h;
  Cell(float x, float y, float w, float h) { this.x=x; this.y=y; this.w=w; this.h=h; }
}

ArrayList<Cell> cells = new ArrayList<Cell>();
int seed = 12345;
float margin = 60;
float minW = 110, minH = 110;       
float lineW = 22;                   
final color C_WHITE  = color(245);
final color C_BLACK  = color(0);
final color C_RED    = color(212, 9, 32);
final color C_BLUE   = color(19, 86, 162);
final color C_YELLOW = color(247, 216, 66);
color[] palette = { C_RED, C_BLUE, C_YELLOW };

void setup() {
  size(900, 900);
  smooth(8);
  noLoop();
}

void draw() {
  randomSeed(seed);
  background(C_WHITE);

  cells.clear();
  cells.add(new Cell(margin, margin, width - 2*margin, height - 2*margin));

  // Randomly select a cell multiple times for horizontal/vertical splitting
  for (int iter = 0; iter < 60; iter++) {
    if (cells.size() <= 0) break;
    int idx = int(random(cells.size()));
    Cell c = cells.get(idx);

    boolean canV = c.w > minW * 1.8;
    boolean canH = c.h > minH * 1.8;

    if (!canV && !canH) continue;

    if ((canV && !canH) || (canV && random(1) < 0.5)) {
      // Vertical split
      float sx = c.x + random(minW, c.w - minW);
      Cell left  = new Cell(c.x, c.y, sx - c.x, c.h);
      Cell right = new Cell(sx, c.y, c.x + c.w - sx, c.h);
      cells.remove(idx);
      cells.add(left);
      cells.add(right);
    } else {
      // Horizontal split
      float sy = c.y + random(minH, c.h - minH);
      Cell top    = new Cell(c.x, c.y, c.w, sy - c.y);
      Cell bottom = new Cell(c.x, sy, c.w, c.h - (sy - c.y));
      cells.remove(idx);
      cells.add(top);
      cells.add(bottom);
    }
  }

  // Draw a white rectangle first (no stroke)
  noStroke();
  fill(C_WHITE);
  for (Cell c : cells) {
    pushMatrix();
    translate(c.x, c.y);           // Use local coordinates (demonstrates transform)
    rect(0, 0, c.w, c.h);
    popMatrix();
  }

  // Select some rectangles to color (larger areas are given priority)
  int targetColored = int(random(5, 9));
  ArrayList<Integer> chosen = new ArrayList<Integer>();
  for (int k = 0; k < targetColored; k++) {
    int tries = 0;
    int j;
    do {
      j = int(random(cells.size()));
      tries++;
    } while (tries < 100 && (chosen.contains(j) || area(cells.get(j)) < sq(120)));
    if (!chosen.contains(j)) chosen.add(j);
  }

  for (int j : chosen) {
    Cell c = cells.get(j);
    fill(palette[int(random(palette.length))]);
    pushMatrix();
    translate(c.x, c.y);
    rect(0, 0, c.w, c.h);
    popMatrix();
  }

  // Finally, draw a thick black line (stroke)
  noFill();
  stroke(C_BLACK);
  strokeWeight(lineW);
  strokeJoin(MITER);
  for (Cell c : cells) {
    rect(c.x, c.y, c.w, c.h);
  }
}

float area(Cell c) { return c.w * c.h; }

void keyPressed() {
  if (key == 'r' || key == 'R') { seed = int(random(1 << 20)); redraw(); }
  if (key == 's' || key == 'S') { saveFrame("week03_mondrian-####.png"); }
  if (key == '+') { minW += 10; minH += 10; redraw(); }
  if (key == '-') { minW = max(60, minW - 10); minH = max(60, minH - 10); redraw(); }
}
