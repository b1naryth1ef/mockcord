module mockcord.gateway.server;

import mockcord.state : State;
import mockcord.server : Server;

class GatewayServer : Server {
  State state;

  this(State state) {
    this.state = state;
  }

  void serveForever(string hostString) {

  }
}
