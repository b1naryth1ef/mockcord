module mockcord.main;

import std.stdio,
       std.getopt;

import vibe.core.core : runEventLoop;

import mockcord.state : State;
import mockcord.api.server : APIServer;
import mockcord.voice.server : VoiceServer;
import mockcord.gateway.server : GatewayServer;

enum HumanBool { no, yes };

/// Command line arguments storage
struct Arguments {
  HumanBool enableAPI = HumanBool.yes;
  HumanBool enableGateway = HumanBool.yes;
  HumanBool enableVoice = HumanBool.yes;

  string apiBind = "0.0.0.0:8660";
  string gatewayBind = "0.0.0.0:8661";
  string voiceBind = "0.0.0.0:8662";

  // API Options
  bool apiRateLimits = true;
}

int main(string[] rawargs) {
  Arguments args;

  auto info = getopt(
    rawargs,
    "enable-api|a", "Enable the HTTP REST API", &args.enableAPI,
    "enable-gateway|g", "Enable the Websocket Gateway", &args.enableGateway,
    "enable-voice|v", "Enable the Voice server", &args.enableVoice,
    "api-bind", "Hoststring to bind the HTTP REST API to", &args.apiBind,
    "gateway-bind", "Hoststring to bind the Websocket Gateway to", &args.gatewayBind,
    "voice-bind", "Hoststring to bind the Voice server to", &args.voiceBind,
    "api-ratelimits", "Enable ratelimits for the API", &args.apiRateLimits);

  auto state = new State;

  if (args.enableAPI) {
    (new APIServer(state)).serveForever(args.apiBind);
  }

  if (args.enableGateway) {
    (new GatewayServer(state)).serveForever(args.gatewayBind);
  }

  if (args.enableVoice) {
    (new VoiceServer(state)).serveForever(args.voiceBind);
  }

  runEventLoop();

  return 0;
}
