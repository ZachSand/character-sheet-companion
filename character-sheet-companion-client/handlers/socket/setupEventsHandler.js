import { ServerSocketRequestEvents } from "../../events/socket/ServerSocketRequestEvents.js";
import {
  removeHtml,
  validSocketArguments,
} from "../../utils/commonUtilities.js";
import { CORE_EVENTS } from "../../events/coreEvents.js";
import { FoundrySocketEvents } from "../../events/socket/FoundrySocketEvents.js";

export const IOS_DATA_MAP = new Map();

export function handleSetupEvents(socket) {
  Object.values(
    ServerSocketRequestEvents.Instance().FOUNDRY_EVENTS.SETUP
  ).forEach((setupEvent) => {
    socket.on(
      ServerSocketRequestEvents.Instance().FOUNDRY_EVENTS.SETUP + setupEvent,
      async (...args) => {
        await handleSetupEvent(socket, setupEvent, args);
      }
    );
  });
}

export async function handleSetupEvent(socket, setupEvent, args) {
  if (!args || args.length < 1) {
    //TODO: Error
  }

  let iosSocketId = args[args.length - 1];
  switch (_.startCase(_.camelCase(setupEvent))) {
    case CORE_EVENTS.WORLD_DATA:
      if (validSocketArguments(socket, setupEvent, args, 1)) {
        getAndEmitWorldData(socket, iosSocketId);
      }
      break;
    case CORE_EVENTS.WORLD_USERS:
      if (validSocketArguments(socket, setupEvent, args, 1)) {
        getAndEmitUsers(socket, iosSocketId);
      }
      break;
    case CORE_EVENTS.WORLD_USER_AUTH:
      if (validSocketArguments(socket, setupEvent, args, 2)) {
        await getAndEmitUserAuth(socket, args[0], iosSocketId);
      }
      break;
    case CORE_EVENTS.SETUP_COMPLETE:
      if (validSocketArguments(socket, setupEvent, args, 3)) {
        completeSetup(args[0], args[1], iosSocketId);
      }
      break;
    default:
    //TODO: some error
  }

  function getAndEmitWorldData(socket, iosSocketId) {
    socket.emit(
      FoundrySocketEvents.Instance().FOUNDRY_EVENTS.SETUP.WORLD_DATA,
      {
        id: game.world.id,
        title: game.world.data.title,
        version: game.world.data.version,
        description: game.world.data.description
          ? removeHtml(game.world.data.description)
          : "No description",
        coreVersion: game.world.data.coreVersion,
        system: game.world.data.system,
      },
      iosSocketId
    );
  }

  function getAndEmitUsers(socket, iosSocketId) {
    socket.emit(
      FoundrySocketEvents.Instance().FOUNDRY_EVENTS.SETUP.WORLD_USERS,
      {
        users: game.users.map((user) => {
          return {
            id: user.data._id,
            isActive: user.active,
            name: user.data.name,
            actors: game.actors
              .filter((actor) => actor.type === "character")
              .filter((actor) => actor.testUserPermission(user, "OWNER"))
              .map((actor) => {
                return {
                  id: actor.data._id,
                  name: actor.data.name,
                };
              }),
          };
        }),
      },
      iosSocketId
    );
  }

  async function getAndEmitUserAuth(socket, setupUserAuth, iosSocketId) {
    let setupUserAuthObj = JSON.parse(setupUserAuth);
    if (setupUserAuthObj) {
      await verifyUserAuth({
        userid: setupUserAuthObj.id,
        password: setupUserAuthObj.password,
        adminKey: "",
        action: "join",
      }).then((response) => {
        if (response.ok) {
          setupUserAuthObj.passwordMatches = true;
          socket.emit(
            FoundrySocketEvents.Instance().FOUNDRY_EVENTS.SETUP.WORLD_USER_AUTH,
            setupUserAuthObj,
            iosSocketId
          );
        } else {
          setupUserAuthObj.passwordMatches = false;
          socket.emit(
            FoundrySocketEvents.Instance().FOUNDRY_EVENTS.SETUP.WORLD_USER_AUTH,
            setupUserAuthObj,
            iosSocketId
          );
        }
      });
    }
  }

  function verifyUserAuth(data) {
    return fetch("join", {
      method: "POST",
      mode: "cors",
      cache: "no-cache",
      credentials: "same-origin",
      headers: {
        "Content-Type": "application/json",
      },
      referrerPolicy: "strict-origin-when-cross-origin",
      body: JSON.stringify(data),
    });
  }

  function completeSetup(actorId, userId, iosSocketId) {
    IOS_DATA_MAP.set(actorId, {
      userId: userId,
      iosSocketId: iosSocketId,
    });
  }
}
