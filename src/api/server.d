module mockcord.api.server;

import std.stdio;

import std.conv : to;
import std.algorithm : canFind, startsWith;
import std.array : split;

import vibe.http.server : listenHTTP, HTTPServerRequest, HTTPServerResponse, HTTPServerSettings;
import vibe.http.router : URLRouter;

import mockcord.state : State;
import mockcord.server : Server;
import mockcord.api.routes.user : UserRoutes;
import mockcord.api.routes.guild: GuildRoutes;

class APIServer : Server {
  URLRouter router;
  State state;

  this(State state) {
    this.state = state;
    this.router = new URLRouter;
    this.addRoutes!UserRoutes;
    this.addRoutes!GuildRoutes;
    writefln("%s", this.router.getAllRoutes());
  }

  void addRoutes(T)() {
    (new T(this)).bind();
  }

  void serveForever(string hostString) {
    ushort port = 8660;

    auto settings = new HTTPServerSettings;

    if (hostString.canFind(":")) {
      string[] parts = hostString.split(":");
      settings.bindAddresses ~= parts[0];
      port = parts[1].to!ushort;
    } else {
      settings.bindAddresses ~= hostString;
    }

    settings.accessLogToConsole = true;
    settings.port = port;
    listenHTTP(settings, &this.handleRequest);
  }

  void handleRequest(HTTPServerRequest req, HTTPServerResponse res) {
    if (!req.requestURL.startsWith("/api")) {
      // TODO: replicate flask here
      return;
    }

    req.requestURL = req.requestURL[4..$];

    if (!req.requestURL.startsWith("/v6")) {
      // TODO: blah
      return;
    }

    req.requestURL = req.requestURL[3..$];
    req.path = req.requestURL;

    return this.router.handleRequest(req, res);
  }
}
