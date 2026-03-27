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
      for (int i = 0; i < infos.length; i++) {
        if (infos[i].getName().equals("Real Time Sequencer")) {
          device = MidiSystem.getMidiDevice(infos[i]);
          device.open();
          device.getTransmitter().setReceiver(new Receiver() {
            public void send(MidiMessage msg, long timestamp) {
              if (msg instanceof ShortMessage) {
                ShortMessage sm = (ShortMessage) msg;
                if (sm.getCommand() == ShortMessage.NOTE_ON) {
                  parent.handleMidiInput(sm.getData1(), sm.getData2());
                }
              }
            }
            public void close() {}
          });
          break;
        }
      }
    } catch (Exception e) {
      System.out.println("MIDI error: " + e);
    }
  }

  public void close() {
    if (device != null) device.close();
  }
}
