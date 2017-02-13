module mockcord.state;

import dscord.types.user : User;

class State {
  User me;

  this() {
    this.me = new User;
    this.me.id = 280519437256228864;
    this.me.username = "Mocky";
    this.me.discriminator = "1234";
    this.me.verified = true;
    this.me.email = "mocky@mockcord.xd";
  }
}
