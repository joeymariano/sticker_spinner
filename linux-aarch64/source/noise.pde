class Noise {
  float[] x;
  float[] strokeWeights;
  float[] strokeColors;
  int numLines;

  Noise(int numLines) {
    this.numLines = numLines;
    x = new float[numLines];
    strokeWeights = new float[numLines];
    strokeColors = new float[numLines];
    initializeLines();
  }

  void initializeLines() {
    for (int i = 0; i < numLines; i++) {
      x[i] = random(displayWidth);
      strokeWeights[i] = random(1, 6);
      strokeColors[i] = random(255);
    }
  }

  void updateLines() {
    for (int i = 0; i < numLines; i++) {
      x[i] = random(displayWidth);
      strokeWeights[i] = random(1, 6);
      strokeColors[i] = random(255);
    }
  }

  void drawLines() {
    for (int i = 0; i < numLines; i++) {
      strokeWeight(strokeWeights[i]);
      stroke(strokeColors[i]);
      line(x[i], 0, x[i], height);
    }
  }

  void update() {
    if (frameCount % 8 == 0) {
      updateLines();
    }
    drawLines();
  }
}
