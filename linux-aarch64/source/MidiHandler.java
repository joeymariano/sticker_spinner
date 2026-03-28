import javax.sound.midi.*;

public class MidiHandler {
  private MidiDevice device;
  private sticker_spinner parent;

  public MidiHandler(sticker_spinner parent) {
    this.parent = parent;
  }

  public void setup() {
    try {
      MidiDevice.Info[] infos = MidiSystem.getMidiDeviceInfo();

      System.out.println("Available MIDI devices:");
      for (int i = 0; i < infos.length; i++) {
        MidiDevice dev = MidiSystem.getMidiDevice(infos[i]);
        System.out.println("  [" + i + "] " + infos[i].getName()
            + " maxTx=" + dev.getMaxTransmitters());
      }

      // Open the first VirMIDI device that can transmit to us.
      // VirMIDI bridges the ALSA sequencer port (RigMIDI, from controller.py)
      // to a raw MIDI device that Java can enumerate.
      for (int i = 0; i < infos.length; i++) {
        String name = infos[i].getName();
        if (name.startsWith("VirMIDI")) {
          MidiDevice dev = MidiSystem.getMidiDevice(infos[i]);
          if (dev.getMaxTransmitters() != 0) {
            device = dev;
            device.open();
            device.getTransmitter().setReceiver(new Receiver() {
              public void send(MidiMessage msg, long timestamp) {
                if (msg instanceof ShortMessage) {
                  ShortMessage sm = (ShortMessage) msg;
                  if (sm.getCommand() == ShortMessage.NOTE_ON && sm.getData2() > 0) {
                    parent.handleMidiInput(sm.getData1(), sm.getData2());
                  }
                }
              }
              public void close() {}
            });
            System.out.println("MIDI: Connected to " + name);
            return;
          }
        }
      }
      System.out.println("MIDI: VirMIDI not found — is snd_virmidi loaded?");
    } catch (Exception e) {
      System.out.println("MIDI error: " + e);
    }
  }

  public void close() {
    if (device != null) device.close();
  }
}
