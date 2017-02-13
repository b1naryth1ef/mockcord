module mockcord.state;

import std.format : format;

import dscord.types.user : User, UserMap;
import dscord.types.guild : Guild, GuildMap;

enum REGIONS = [
  "us-central",
  "us-east",
  "us-south",
  "us-west",
  "london",
  "eu-west",
  "amsterdam",
  "eu-central",
  "frankfurt",
  "brazil",
  "hongkong",
  "sydney",
  "singapore"
];

enum RANDOM_USER_IDS = [
  280621246411046922,
  280621274365952001,
  280621289658515457,
  280621304561008640,
  280621319933132800
];

enum RANDOM_GUILD_IDS = [
  280806780047458314,
  280806810879918081,
  280806828026363905,
  280806845269147659,
  280806864684449793,
];

enum RANDOM_TEXT_CHANNEL_IDS = [
  280807937079771136,
  280807956491141120,
  280807972471570434,
  280807990448095234,
  280808005858099200,

];

enum RANDOM_VOICE_CHANNEL_IDS = [
  280808027173421059,
  280808063454281729,
  280808079686238208,
  280808097533132801,
  280808132576542720
];

class State {
  /// Current user
  User me;

  /// Random Users
  UserMap users;

  GuildMap guilds;

  this() {
    this.users = new UserMap;
    this.guilds = new GuildMap;

    this.registerUsers();
    this.registerGuilds();
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

  private void registerGuilds() {
    // create some guilds
    foreach (idx, gid; RANDOM_GUILD_IDS) {
      bool even = (idx % 2 == 0);
      this.guilds[gid] = new Guild;
      this.guilds[gid].id = gid;
      this.guilds[gid].name = format("Discord %s", gid);
      this.guilds[gid].icon = null;
      this.guilds[gid].splash = null;
      this.guilds[gid].ownerID = RANDOM_USER_IDS[idx];
      this.guilds[gid].region = REGIONS[idx];
      this.guilds[gid].afkChannelID = RANDOM_VOICE_CHANNEL_IDS[idx];
      this.guilds[gid].afkTimeout = (cast(int)idx + 1) * 100;
      this.guilds[gid].embedEnabled = even;
      this.guilds[gid].embedChannelID = RANDOM_TEXT_CHANNEL_IDS[idx];
      this.guilds[gid].verificationLevel = 1;
      this.guilds[gid].features = [];
      this.guilds[gid].unavailable = false;
    }
    // throw in an unavailable one for maximum spoops
    ulong ugid = 280806903800528896;
    this.guilds[ugid] = new Guild;
    this.guilds[ugid].id = ugid;
    this.guilds[ugid].unavailable = true;
  }
}
