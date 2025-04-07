class Bytebeat {
  int t;  // Time variable
  int pixelSize;  // Size of each "pixel" in pixels
  int frameDelay;  // Number of frames to hold each frame before updating
  int frameCounter;  // Counter to track the number of frames
  color[] pixelColors;  // Array to store pixel colors

  Bytebeat(int pixelSize, int frameDelay) {
    this.t = 0;
    this.pixelSize = pixelSize;
    this.frameDelay = frameDelay;
    this.frameCounter = 0;
    this.pixelColors = new color[(width / pixelSize) * (height / pixelSize)];
  }

  void updateFrame() {
    frameCounter++;  // Increment the frame counter

    if (frameCounter >= frameDelay) {
      // Reset the frame counter
      frameCounter = 0;

      // Update the pixel colors
      int index = 0;
      for (int y = 0; y < height; y += pixelSize) {
        for (int x = 0; x < width; x += pixelSize) {
          // Use a bytebeat formula to generate a value
          //int value = (t * (x & ((y ^ 255) >> 1))) & 255; // Adjusted to avoid dimness

          // Uncomment one of the following formulas to try different effects
          // int value = (t + (x * y)) & 255;  // Default bytebeat formula
          // int value = (t * (x ^ y)) & 255;
          // int value = (t * ((x & y) | (x ^ y))) & 255;
          //// int value = (t * (x | y)) & 255;
          // int value = (t * (x & (y >> 4))) & 255;
          // int value = ((t >> 1) & (x ^ y)) & 255;
          // int value = (t * (x >> (y & 3))) & 255;
          // int value = (t ^ ((x & t) | (y >> 3))) & 255;
          // int value = ((t >> 2) | (x & y)) & 255; // Adjusted to avoid being too slow
          // int value = (t * ((x ^ y) >> 2)) & 255; // Adjusted to avoid a black screen
           int value = (t * (x | (y >> 2))) & 255;
          // int value = ((t & (x >> 3)) | (y >> 1)) & 255; // Adjusted for better visibility
           //int value = ((t & ((x * y) >> 1)) | 128) & 255; // Adjusted to avoid black screen

          // Generate a color based on the value
          color col;
          float brightness = map(value, 0, 255, 0, 1);
          switch (value % 3) {
            case 0: col = color(255 * brightness, 0, 0); break;  // Red gradient
            case 1: col = color(0, 255 * brightness, 0); break;  // Green gradient
            case 2: col = color(0, 0, 255 * brightness); break;  // Blue gradient
            default: col = color(255 * brightness, 255 * brightness, 255 * brightness); break;  // White gradient
          }

          // Store the color in the array
          pixelColors[index++] = col;
        }
      }

      t++;  // Increment time
    }
  }

  void drawFrame() {
    // Draw the pixel colors stored in the array
    int index = 0;
    for (int y = 0; y < height; y += pixelSize) {
      for (int x = 0; x < width; x += pixelSize) {
        fill(pixelColors[index++]);
        noStroke();
        rect(x, y, pixelSize, pixelSize);
      }
    }
  }
}
