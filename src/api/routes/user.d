module mockcord.api.routes.user;

import mockcord.api.routes;


import dscord.util.json : serializeToJSON;
import dscord.types.user : User;

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
    } else {
      // TODO
    }

    res.statusCode = 200;
  }
}
