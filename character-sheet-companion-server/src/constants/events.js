"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.VALID_EVENTS = exports.SOCKET_EVENTS = void 0;
exports.SOCKET_EVENTS = {
    FOUNDRY: {
        JOIN_ROOM: "foundry:join",
        JOINED_ROOM: "foundry:joinedRoom",
        SEND_USERS: "foundry:sendUsers",
        SEND_USER_ACTORS: "foundry:sendUserActors",
        SEND_ACTOR_DATA: "foundry:sendActorData",
        SEND_ABILITY_ROLL: "foundry:sendAbilityRoll",
        SEND_SKILL_ROLL: "foundry:sendSkillRoll",
    },
    IOS: {
        JOIN_ROOM: "ios:join",
        JOINED_ROOM: "ios:joinedRoom",
        REQUEST_FOUNDRY_USERS: "ios:requestFoundryUsers",
        REQUEST_FOUNDRY_USER_ACTORS: "ios:requestFoundryUserActor",
        REQUEST_FOUNDRY_ACTOR_DATA: "ios:requestFoundryActorData",
        REQUEST_FOUNDRY_ABILITY_ROLL: "ios:requestFoundryAbilityRoll",
        REQUEST_FOUNDRY_SKILL_ROLL: "ios:requestFoundrySkillRoll",
    },
    SERVER: {
        REQUEST_FOUNDRY_USERS: "server:requestFoundryUsers",
        REQUEST_FOUNDRY_USER_ACTORS: "server:requestFoundryUserActors",
        REQUEST_FOUNDRY_ACTOR_DATA: "server:requestFoundryActorData",
        REQUEST_FOUNDRY_ABILITY_ROLL: "server:requestFoundryAbilityRoll",
        REQUEST_FOUNDRY_SKILL_ROLL: "server:requestFoundrySkillRoll",
        SEND_FOUNDRY_USERS: "server:sendFoundryUsers",
        SEND_FOUNDRY_USER_ACTORS: "server:sendFoundryUserActor",
        SEND_FOUNDRY_ACTOR_DATA: "server:sendFoundryActorData",
        SEND_FOUNDRY_ABILITY_ROLL: "server:sendFoundryAbilityRoll",
        SEND_FOUNDRY_SKILL_ROLL: "server:sendFoundrySkillRoll",
    },
    ERROR: {
        GENERAL_ERROR: "error",
        JOIN_ROOM: "error:join-room",
    },
    GENERAL: {
        DISCONNECT: "disconnect",
    },
};
exports.VALID_EVENTS = new Set(Object.values(exports.SOCKET_EVENTS.FOUNDRY).concat(Object.values(exports.SOCKET_EVENTS.IOS), Object.values(exports.SOCKET_EVENTS.SERVER), Object.values(exports.SOCKET_EVENTS.ERROR), Object.values(exports.SOCKET_EVENTS.GENERAL)));
