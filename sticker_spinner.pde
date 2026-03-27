import java.io.File;
import java.util.Arrays;

color blue = #2bd1fc;
color grey = #333333;

Grid grid;
Noise noise;
RasterBars rasterBars;
Bytebeat bytebeat;
Plasma plasma;
OpArt opArt;
ArcadeShag arcadeShag;
CommodoreTunnel commodoreTunnel;
VectorTunnel vectorTunnel;

MidiHandler midiHandler;

PImage[] stickerFiles;
Sticker[] stickers;

int pickBackground;
int pickSticker = 1;
int pickStickerRoutine = 1;

boolean releaseBackground = false;

void setup() {
  fullScreen();
  //size(320, 240);
  noCursor();
  noSmooth();
  imageMode(CENTER);

  // Get list of files in data folder and filter for images
  File dataFolder = new File(dataPath(""));
  File[] files = dataFolder.listFiles();
  Arrays.sort(files); // Sort files alphabetically

  int numImages = 0;
  for (File file : files) {
    if (isImageFile(file)) {
      numImages++;
    }
  }

  stickerFiles = new PImage[numImages];
  stickers = new Sticker[numImages];

  int index = 0;
  for (File file : files) {
    if (isImageFile(file)) {
      stickerFiles[index] = loadImage(file.getName());
      stickers[index] = new Sticker(stickerFiles[index]);
      index++;
    }
  }

  grid = new Grid();
  noise = new Noise(24);
  rasterBars = new RasterBars();
  bytebeat = new Bytebeat(10, 5);
  plasma = new Plasma(10);  // Initialize the visualizer with pixelSize
  opArt = new OpArt(2, 100, 10); // rotationSpeed, tileSize, stepSize, frameDelay
  arcadeShag = new ArcadeShag(0.02, 20, 4);
  commodoreTunnel = new CommodoreTunnel(16, 0.05);
  commodoreTunnel.setup();
  vectorTunnel = new VectorTunnel(12, 30, 40, 0.25, 80);

  midiHandler = new MidiHandler(this);
  midiHandler.setup();
}

void draw() {

  if (!releaseBackground) {
    background(0);
  }

  // Draw background
  switch (pickBackground) {
  default:
    rasterBars.update(); // Bug if removed for some reason
    break;
  case 1:
    grid.update(blue);
    break;
  case 2:
    noise.update();
    break;
  case 3:
    rasterBars.update();
    break;
  case 4:
    bytebeat.updateFrame();
    bytebeat.drawFrame();
    break;
  case 5:
    plasma.updatePalette();  // Update the color palette
    plasma.drawPlasma();     // Draw the plasma effect
    break;
  case 6:
    opArt.display();
    break;
  case 7:
    arcadeShag.display();
    break;
  case 8:
    commodoreTunnel.display();
    break;
  case 9:
    vectorTunnel.display();
    break;
  case 10:

    break;
  }

  // Draw foreground
  translate(displayWidth / 2, displayHeight / 2);
  if (pickSticker > 0 && pickSticker <= stickers.length) {
    handleStickerRoutine(stickers[pickSticker - 1], pickStickerRoutine);
  }
}

void handleStickerRoutine(Sticker sticker, int routine) {
  switch (routine) {
  case 1:
    // Subtle hover effect
    sticker.hover(0.12, 2); // Slower rate, more noticeable hover
    break;
  case 2:
    // Dynamic bounce effect
    sticker.bounce(0.18, 0.7, 1.3); // Slightly faster, more exaggerated bounce
    break;
  case 3:
    // Wobble effect with small amplitude
    sticker.wobble(0.08, 0.15); // Slower wobble, more subtle
    break;
  case 4:
    // Rotate and scale with dramatic range
    sticker.rotateAndScale(0.03, 4); // Slower rate, wider scale range for more drama
    break;
  case 5:
    // Pulsate with stronger scaling
    sticker.pulsate(0.06, 0.8, 8); // More pronounced scale range, faster rate
    break;
  case 6:
    // Smooth fade in and out
    sticker.fadeInOut(0.02); // Keep rate slow for a smooth fade
    break;
  case 7:
    // Spin horizontally (already defined)
    sticker.spinHorizontal();
    break;
  case 8:
    // Spin vertically (already defined)
    sticker.spinVertical();
    break;
  case 9:
    // Spin flat to the right (already defined)
    sticker.spinFlatRight();
    break;
  case 10:
    // Spin flat to the left (already defined)
    sticker.spinFlatLeft();
    break;
  }
}

boolean isImageFile(File file) {
  String[] imageExtensions = { "gif", "png", "jpg", "jpeg" };
  String fileName = file.getName().toLowerCase();
  for (String ext : imageExtensions) {
    if (fileName.endsWith(ext)) {
      return true;
    }
  }
  return false;
}

void dispose() {
  if (midiHandler != null) midiHandler.close();
}
