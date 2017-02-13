module mockcord.api.routes.guild;

import std.conv : to;
import std.format : format;

import mockcord.api.routes;

import dscord.util.json : VibeJSON, serializeToJSON;
import dscord.types : Snowflake, Guild;

import std.stdio;

class GuildRoutes {
  mixin Routes;

  void bind() {
    // Guild Routes
    this.router.get("/guilds/:guildID", &this.getGuild);
  }

  void getGuild(HTTPServerRequest req, HTTPServerResponse res) {
    auto guildID = req.params["guildID"];

    Snowflake realGuildID;

    try {
      realGuildID = guildID.to!Snowflake;
    } catch (Throwable) {
      VibeJSON obj = VibeJSON.emptyObject;
      obj["guild_id"] = VibeJSON([VibeJSON(format("Value \"%s\" is not snowflake.", guildID))]);
      res.writeJsonBody(obj);
      res.statusCode = 400;
      return;
    }

    if (state.guilds.has(realGuildID)) {
      res.writeJsonBody(state.guilds[realGuildID].serializeToJSON);
      res.statusCode = 200;
      return;
    }

    res.writeJsonBody(VibeJSON([
      "code": VibeJSON(10004),
      "message": VibeJSON("Unknown Guild"),
    ]));

    res.statusCode = 400;
  }
}
