class CommodoreTunnel {
  int pixelSize;
  int cols, rows;
  float[][] wave;
  float angle;
  float waveSpeed;
  color[] palette;
  int pixelHeight; // Declare pixelHeight as an int

  CommodoreTunnel(int pixelSize, float waveSpeed) {
    this.pixelSize = pixelSize;
    this.waveSpeed = waveSpeed;
    this.angle = 0.0;
    this.palette = new color[]{
      #ffffff, #c9d487, #9ae29b, #adadad, #cb7e75,
      #9f4e44, #a1683c, #626262, #898989, #887ecb,
      #6abfc6, #a057a3, #5cab5e, #50459b, #6d5412,
      #000000
    };
    this.pixelHeight = int(pixelSize * 0.75); // Convert to int
  }

  void setup() {
    noStroke();
    fullScreen();
    cols = width / pixelSize;
    rows = height / pixelHeight; // Adjust rows to use pixelHeight
    wave = new float[cols][rows];
    noSmooth(); // Disable anti-aliasing for crisp pixel edges
  }

  void updateWave() {
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        float distance = dist(x * pixelSize, y * pixelHeight, width / 2, height / 2);
        wave[x][y] = sin(angle + distance * 0.1);
      }
    }
  }

  void drawWave() {
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        float value = wave[x][y];
        int colorIndex = int(map(value, -1, 1, 0, palette.length - 1));
        fill(palette[colorIndex]);
        rect(x * pixelSize, y * pixelHeight, pixelSize, pixelHeight); // Use pixelHeight for height
      }
    }
  }

  void shiftPalette() {
    color last = palette[palette.length - 1];
    for (int i = palette.length - 1; i > 0; i--) {
      palette[i] = palette[i - 1];
    }
    palette[0] = last;
  }

  void display() {
    background(0);
    updateWave();
    noStroke();
    drawWave();
    if (frameCount % 64 == 0) {
      shiftPalette(); // Shift the palette colors
    }
    angle += waveSpeed;
  }
}
