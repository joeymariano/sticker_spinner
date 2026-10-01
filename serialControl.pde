import processing.serial.*;

// Hardware buttons from the sticker_controller ESP32-C3 (see ../sticker_controller)
Serial controller;

String controllerById = "/dev/serial/by-id/usb-Espressif_USB_JTAG_serial_debug_unit_84:FC:E6:00:94:88-if00";

void setupController() {
  String portName = findControllerPort();
  if (portName == null) {
    println("Sticker controller warning: no ESP32-C3 found, buttons disabled");
    return;
  }
  try {
    controller = new Serial(this, portName, 115200);
    controller.bufferUntil('\n');
    println("Sticker controller connected on " + portName);
  } catch (Exception e) {
    println("Sticker controller warning: couldn't open " + portName + " (" + e.getMessage() + ")");
    controller = null;
  }
}

String findControllerPort() {
  // Prefer the stable by-id link, since ttyACM numbers change on replug
  File byId = new File(controllerById);
  if (byId.exists()) {
    try {
      return byId.getCanonicalPath();
    } catch (IOException e) {
    }
  }
  for (String port : Serial.list()) {
    if (port.contains("ttyACM")) {
      return port;
    }
  }
  return null;
}

void serialEvent(Serial port) {
  String message = port.readStringUntil('\n');
  if (message == null) return;
  message = message.trim();
  if (message.length() == 0) return;

  switch (message.charAt(0)) {
  case 'U': // D3
    prevBackground();
    break;
  case 'R': // D4
    nextSticker();
    break;
  case 'S': // D5 pressed
    releaseBackground = true;
    break;
  case 's': // D5 released
    releaseBackground = false;
    break;
  case 'M': // D6
    nextRoutine();
    break;
  }
}
