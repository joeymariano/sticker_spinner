class ArcadeShag {
  float noiseScale;
  float stepSize;
  int strokeWeight;

  ArcadeShag(float noiseScale, float stepSize, int strokeWeight) {
    this.noiseScale = noiseScale;
    this.stepSize = stepSize;
    this.strokeWeight = strokeWeight;
  }

  void display() {
    background(0);
  
    float time = millis() * 0.001;
  
    for (float i = 0; i < width; i += this.stepSize) {
      for (float j = 0; j < height; j += this.stepSize) {
        float xNoise = noise(i * this.noiseScale, j * this.noiseScale, time);
        float yNoise = noise(i * this.noiseScale, j * this.noiseScale + 1000, time);
        float angle = TWO_PI * xNoise;
      
        float x1 = i + this.stepSize * cos(angle);
        float y1 = j + this.stepSize * sin(angle);
      
        float r = map(cos(TWO_PI * xNoise + time), -1, 1, 0, 255);
        float g = map(cos(TWO_PI * yNoise + time), -1, 1, 0, 255);
        float b = map(cos(TWO_PI * (xNoise + yNoise) + time), -1, 1, 0, 255);
        pushMatrix();
        scale(2);
        stroke(r, g, b);
        strokeWeight(this.strokeWeight);
        line(i, j, x1, y1);
        popMatrix();
      }
    }
  }
}
