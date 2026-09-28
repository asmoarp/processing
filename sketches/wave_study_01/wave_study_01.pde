// Wave Study 01
// Studio Godi L'onda
//
// Layered horizontal waves shaped by Perlin noise.
// Each run starts from a new seed.
//
// Keys:
//   s  save a PNG to the output folder
//   r  new seed (fresh composition)
//   p  pause or resume the motion

int layers = 28;
float margin = 90;
float t = 0;
boolean paused = false;
long seed;

color paper = #F3EEE6;
color[] ink = { #1B2A41, #324A5F, #0C7C8C, #E07A5F, #C9B79C };

void setup() {
  size(1080, 1350);  // 4:5 portrait, ready for social
  pixelDensity(displayDensity());
  newSeed();
}

void draw() {
  background(paper);
  noFill();
  strokeWeight(1.6);

  for (int i = 0; i < layers; i++) {
    float f = i / float(layers - 1);
    float baseY = lerp(margin + 120, height - margin, f);
    float amp = lerp(30, 140, f);

    stroke(ink[i % ink.length], lerp(90, 230, f));
    beginShape();
    for (float x = margin; x <= width - margin; x += 6) {
      float n = noise(x * 0.004, i * 0.12, t);
      curveVertex(x, baseY - n * amp);
    }
    endShape();
  }

  if (!paused) t += 0.004;
}

void newSeed() {
  seed = (long) random(1000000);
  noiseSeed(seed);
  randomSeed(seed);
  t = 0;
}

void keyPressed() {
  if (key == 's') saveFrame("output/wave_study_01-" + seed + "-####.png");
  if (key == 'r') newSeed();
  if (key == 'p') paused = !paused;
}
