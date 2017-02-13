module mockcord.state;

import std.format : format;

import dscord.types.user : User, UserMap;

enum RANDOM_USER_IDS = [
  280621246411046922,
  280621274365952001,
  280621289658515457,
  280621304561008640,
  280621319933132800
];

class State {
  /// Current user
  User me;

  /// Random Users
  UserMap users;

  this() {
    this.users = new UserMap;

    this.registerUsers();
  }

  private void registerUsers() {
    // Create this user
    this.me = new User;
    this.me.id = 280519437256228864;
    this.me.username = "Mocky";
    this.me.discriminator = "1234";
    this.me.verified = true;
    this.me.email = "mocky@mockcord.xd";
    this.users[this.me.id] = this.me;

    foreach (idx, uid; RANDOM_USER_IDS) {
      this.users[uid] = new User;
      this.users[uid].id = uid;
      this.users[uid].username = format("Joe %s", uid);
      this.users[uid].discriminator = format("%04s", idx + 1);
    }
  }
}
