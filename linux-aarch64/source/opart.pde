class OpArt {
  int tileSize;
  float rotationSpeed; // Speed of rotation for animation
  float stepSize; // Step size for pixelated effect
  float rotationAngle = 0; // Store the current rotation angle

  OpArt(float rotationSpeed, int tileSize, float stepSize) {
    this.rotationSpeed = rotationSpeed;
    this.tileSize = tileSize;
    this.stepSize = stepSize;
  }

  void display() {
    // Update the rotation angle based on the rotation speed
    rotationAngle += radians(rotationSpeed);

    for (int y = 0; y < height; y += tileSize) {
      for (int x = 0; x < width; x += tileSize) {
        pushMatrix();
        scale(3.78);
        translate(x + tileSize / 2, y + tileSize / 2);
        rotate(rotationAngle % TWO_PI); // Use the updated rotation angle
        drawTile(tileSize / 2);
        popMatrix();
      }
    }
  }

  void drawTile(float halfSize) {
    stroke(255); // White lines
    strokeWeight(1);
    fill(0);
    for (float i = halfSize; i > 0; i -= stepSize) { // Adjust step for pixelated effect
      rectMode(CENTER);
      rect(0, 0, i * 2, i * 2);
    }
  }
}
