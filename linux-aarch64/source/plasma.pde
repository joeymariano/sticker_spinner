class Plasma {
  int[] pal;
  int[] buffer;
  int pixelSize;
  int plasmaWidth, plasmaHeight;
  color[] baseColors;

  Plasma(int pixelSize) {
    this.pixelSize = pixelSize;
    this.baseColors = new color[] {color(255, 0, 255), color(0, 255, 255), color(255, 255, 255), color(0, 0, 0)}; // magenta, cyan, white, black
    this.pal = new int[128];
    this.plasmaWidth = width;
    this.plasmaHeight = height;
    this.buffer = new int[plasmaWidth * plasmaHeight];
    initializeBuffer();
  }

  void initializeBuffer() {
    for (int x = 0; x < plasmaWidth; x++) {
      for (int y = 0; y < plasmaHeight; y++) {
        buffer[x + y * plasmaWidth] = int(((128 + (128 * sin(x / 16.0))) // Increased frequency
          + (128 + (128 * cos(y / 16.0))) // Increased frequency
          + (128 + (128 * sin(sqrt((x * x + y * y)) / 16.0)))) / 4); // Increased frequency
      }
    }
  }

  void updatePalette() {
    float s_1, s_2;
    for (int i = 0; i < 128; i++) {
      s_1 = sin(i * PI / 12.5); // Increased frequency
      s_2 = sin(i * PI / 25 + PI / 4); // Increased frequency
      pal[i] = interpolateColors(s_1, s_2);
    }
  }

  color interpolateColors(float s1, float s2) {
    int c1 = int(map(s1, -1, 1, 0, baseColors.length - 1));
    int c2 = (c1 + 1) % baseColors.length;
    float ratio = (s1 + 1) / 2; // map s1 from [-1, 1] to [0, 1]
    return lerpColor(baseColors[c1], baseColors[c2], ratio * (s2 + 1) / 2); // map s2 from [-1, 1] to [0, 1]
  }

  void drawPlasma() {
    loadPixels();
    for (int x = 0; x < width; x += pixelSize) {
      for (int y = 0; y < height; y += pixelSize) {
        int px = x / pixelSize;
        int py = y / pixelSize;
        int col = pal[(buffer[px + py * plasmaWidth] + frameCount) & 127];
        for (int dx = 0; dx < pixelSize; dx++) {
          for (int dy = 0; dy < pixelSize; dy++) {
            int sx = x + dx;
            int sy = y + dy;
            if (sx < width && sy < height) {
              pixels[sx + sy * width] = col;
            }
          }
        }
      }
    }
    updatePixels();
  }
}
