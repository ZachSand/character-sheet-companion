export const SOCKET_EVENTS = {
  FOUNDRY: {
    JOIN_ROOM: "foundry:join",
    JOINED_ROOM: "foundry:joinedRoom",
    SEND_USERS: "foundry:sendUsers",
    SEND_USER_ACTORS: "foundry:sendUserActors",
    SEND_ACTOR_DATA: "foundry:sendActorData",
  },
  IOS: {
    JOIN_ROOM: "ios:join",
    JOINED_ROOM: "ios:joinedRoom",
    REQUEST_FOUNDRY_USERS: "ios:requestFoundryUsers",
    REQUEST_FOUNDRY_USER_ACTORS: "ios:requestFoundryUserActor",
    REQUEST_FOUNDRY_ACTOR_DATA: "ios:requestFoundryActorData",
  },
  SERVER: {
    REQUEST_FOUNDRY_USERS: "server:requestFoundryUsers",
    REQUEST_FOUNDRY_USER_ACTORS: "server:requestFoundryUserActors",
    REQUEST_FOUNDRY_ACTOR_DATA: "server:requestFoundryActorData",
    SEND_FOUNDRY_USERS: "server:sendFoundryUsers",
    SEND_FOUNDRY_USER_ACTORS: "server:sendFoundryUserActor",
    SEND_FOUNDRY_ACTOR_DATA: "server:sendFoundryActorData",
  },
  ERROR: {
    GENERAL_ERROR: "error",
    JOIN_ROOM: "error:join-room",
  },
  GENERAL: {
    DISCONNECT: "disconnect",
  },
};

export const VALID_EVENTS = new Set(
  Object.values(SOCKET_EVENTS.FOUNDRY).concat(
    Object.values(SOCKET_EVENTS.IOS),
    Object.values(SOCKET_EVENTS.SERVER),
    Object.values(SOCKET_EVENTS.ERROR),
    Object.values(SOCKET_EVENTS.GENERAL)
  )
);
