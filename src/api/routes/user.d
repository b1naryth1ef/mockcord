module mockcord.api.routes.user;

import std.conv : to;
import std.format : format;

import mockcord.api.routes;

import dscord.util.json : VibeJSON, serializeToJSON;
import dscord.types : Snowflake, User;

import std.stdio;

class UserRoutes {
  mixin Routes;

  void bind() {
    // User Routes
    this.router.get("/users/:userID", &this.getUser);
  }

  void getUser(HTTPServerRequest req, HTTPServerResponse res) {
    auto userID = req.params["userID"];

    if (userID == "@me") {
      res.writeJsonBody(state.me.serializeToJSON);
      res.statusCode = 200;
      return;
    }

    Snowflake realUserID;

    try {
      realUserID = userID.to!Snowflake;
    } catch (Throwable) {
      VibeJSON obj = VibeJSON.emptyObject;
      obj["user_id"] = VibeJSON([VibeJSON(format("Value \"%s\" is not snowflake.", userID))]);
      res.writeJsonBody(obj);
      res.statusCode = 400;
      return;
    }

    if (state.users.has(realUserID)) {
      res.writeJsonBody(state.users[realUserID].serializeToJSON);
      res.statusCode = 200;
      return;
    }

    res.writeJsonBody(VibeJSON([
      "code": VibeJSON(10013),
      "message": VibeJSON("Unknown User"),
    ]));

    res.statusCode = 400;
  }
}
