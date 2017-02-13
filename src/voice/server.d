module mockcord.voice.server;

import mockcord.state : State;
import mockcord.server : Server;

class VoiceServer : Server {
  State state;

  this(State state) {
    this.state = state;
  }

  void serveForever(string hostString) {

  }
}
