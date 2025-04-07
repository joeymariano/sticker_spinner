class RasterBars {
  float rectSize = 40;
  int[] colorArray = {
    #FFC122,
    #FFCF45,
    #FA5DA3,
    #00B01F,
    #E80235,
    #95A4D7,
    #80C615,
    #02ADE6,
    #0190D8,
  };
  int[] directions; // Array to store direction for each rectangle
  float[] positions; // Array to store y-position for each rectangle
  float speed; // Speed for all rectangles
  float spacing; // Spacing between rectangles
  int frameDelay; // Frame delay between starting positions
  float waveFrequency = 0.05; // Frequency of the sine wave
  float waveAmplitude = 50; // Amplitude of the sine wave

  RasterBars() {
    rectMode(CENTER);
    directions = new int[colorArray.length]; // Same number of directions as colors
    positions = new float[colorArray.length];
    speed = 10; // Set the speed for all rectangles
    spacing = rectSize + 10; // Set spacing to 10 pixels more than the rectangle size
    frameDelay = 8; // Delay between starting each rectangle

    // Initialize directions and positions
    for (int i = 0; i < colorArray.length; i++) {
      directions[i] = 1; // All start moving downwards
      positions[i] = 0; // Start all rectangles at the top of the screen
    }
  }

  void update() {
    // Draw rectangles and update their positions
    pushMatrix();
    for (int i = 0; i < colorArray.length; i++) {
      fill(colorArray[i]);
      noStroke();

      // Calculate sine wave effect for y position
      float sineWave = sin((frameCount + i * frameDelay) * waveFrequency) * waveAmplitude;

      // Apply sine wave effect to the vertical position
      float y = positions[i] + sineWave;
      
      // Draw the rectangle
      rect(displayWidth / 2, y, displayWidth, rectSize);
      
      // Only update position after its delay
      if (frameCount > i * frameDelay) {
        // Update positions based on direction and speed
        positions[i] += speed * directions[i];

        // Check boundary points and switch direction if reached
        if (positions[i] <= 0 || positions[i] >= height) {
          directions[i] *= -1; // Reverse direction
        }
      }
    }
    popMatrix();
  }
}
