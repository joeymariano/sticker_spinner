// Callback function to handle incoming MIDI messages
void noteOn(int channel, int pitch, int velocity) {
  handleMidiInput(pitch, velocity);
}

void handleMidiInput(int pitch, int velocity) {
  switch (pitch) {
    case 48: pickSticker = 0; break; // C2 delete sticker
    case 49: pickSticker = 1; break; // C#
    case 50: pickSticker = 2; break; // D
    case 51: pickSticker = 3; break; // D#
    case 52: pickSticker = 4; break; // E
    case 53: pickSticker = 5; break; // F
    case 54: pickSticker = 6; break; // F#
    case 55: pickSticker = 7; break; // G
    case 56: pickSticker = 8; break; // G#
    case 57: pickSticker = 9; break; // A

    case 60: pickBackground = 1; break; // C3
    case 61: pickBackground = 2; break; // C#
    case 62: pickBackground = 3; break; // D
    case 63: pickBackground = 4; break; // D#
    case 64: pickBackground = 5; break; // E
    case 65: pickBackground = 6; break; // F
    case 66: pickBackground = 7; break; // F#
    case 67: pickBackground = 8;  break; // G3
    case 68: pickBackground = 9;  break; // G#3
    case 69: pickBackground = 10; break; // A3

    case 72: pickStickerRoutine = 1;  break; // C4
    case 73: pickStickerRoutine = 2;  break; // C#4
    case 74: pickStickerRoutine = 3;  break; // D4
    case 75: pickStickerRoutine = 4;  break; // D#4
    case 76: pickStickerRoutine = 5;  break; // E4
    case 77: pickStickerRoutine = 6;  break; // F4
    case 78: pickStickerRoutine = 7;  break; // F#4
    case 79: pickStickerRoutine = 8;  break; // G4
    case 80: pickStickerRoutine = 9;  break; // G#4
    case 81: pickStickerRoutine = 10; break; // A4

    case 84: releaseBackground = true;  break; // C5 — hold background
    case 85: releaseBackground = false; break; // C#5 — release background
  }
}
