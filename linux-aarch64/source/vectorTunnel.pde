class VectorTunnel {
  int numLines;
  int numRings;
  float depth;
  float speed;
  float ringSpacing;

  VectorTunnel(int numLines, int numRings, float depth, float speed, float ringSpacing) {
    this.numLines = numLines;
    this.numRings = numRings;
    this.depth = depth;
    this.speed = speed;
    this.ringSpacing = ringSpacing;
  }

  void display() {
    pushMatrix();
    translate(width / 2, height / 2); // Center of the screen

    float time = millis() * speed; // Time-based movement
    float loopLength = numRings * ringSpacing;

    for (int i = 0; i < numRings; i++) {
      float distance = (i * ringSpacing - time) % loopLength;

      if (distance < 0) {
        distance += loopLength;
      }

      float radius = depth + distance; // Radius of each ring

      beginShape();
      stroke(0, 255, 0); // Green color for vector effect
      strokeWeight(8);   // Thicker lines for retro look
      noFill();
      for (int j = 0; j < numLines; j++) {
        float angle = TWO_PI / numLines * j;
        float x = cos(angle) * radius;
        float y = sin(angle) * radius;

        // Push vertices towards the center as they get closer to the screen
        if (distance < ringSpacing / 2) {
          x *= distance / (ringSpacing / 2);
          y *= distance / (ringSpacing / 2);
        }

        vertex(x, y);
      }
      endShape(CLOSE);
    }
    popMatrix();
  }
}
