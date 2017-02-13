module mockcord.api.routes;

public import mockcord.state : State;
public import vibe.http.router : URLRouter;
public import vibe.http.server : HTTPServerRequest, HTTPServerResponse;
public import mockcord.api.server : APIServer;

mixin template Routes() {
  APIServer server;

  this(APIServer server) {
    this.server = server;
  }

  @property URLRouter router() {
    return this.server.router;
  }

  @property State state() {
    return this.server.state;
  }
}


