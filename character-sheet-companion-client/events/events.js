export const SOCKET_EVENTS = {
    FOUNDRY: {
        JOIN_ROOM: "foundry:join",
        SEND_USERS: "foundry:sendUsers",
        SEND_USER_ACTORS: "foundry:sendUserActors",
        SEND_ACTOR_DATA: "foundry:sendActorData",
    },
    SERVER: {
        REQUEST_FOUNDRY_USERS: "server:requestFoundryUsers",
        REQUEST_FOUNDRY_USER_ACTORS: "server:requestFoundryUserActors",
        REQUEST_FOUNDRY_ACTOR_DATA: "server:requestFoundryActorData",
    },
    ERROR: {
        JOIN_ROOM: "error:join-room",
    },
};
