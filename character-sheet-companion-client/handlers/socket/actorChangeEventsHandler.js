import {
  getValidActor,
  validSocketArguments,
} from "../../utils/commonUtilities.js";
import { SERVER_REQUEST_EVENTS } from "../../events/serverRequestEvents.js";

export function handleActorChangeEvents(socket) {
  Object.values(SERVER_REQUEST_EVENTS.ACTOR_CHANGE).forEach(
    (actorChangeEvent) => {
      socket.on(actorChangeEvent, (...args) => {
        handleActorChangeEvent(socket, actorChangeEvent, args);
      });
    }
  );
}

export function handleActorChangeEvent(socket, actorChangeEvent, args) {
  if (!args || args.length < 2) {
    //TODO: Some error
  }

  let iosSocketId = args[args.length - 1];
  let actor = getValidActor(socket, actorId, iosSocketId);

  if (actor) {
    switch (actorChangeEvent) {
      case SERVER_REQUEST_EVENTS.ACTOR_CHANGE.HEALTH:
        if (validSocketArguments(socket, actorChangeEvent, args, 3)) {
          applyHealthChange(socket, actor, args[1], iosSocketId);
        }
        break;
      case SERVER_REQUEST_EVENTS.ACTOR_CHANGE.SHORT_REST:
        if (validSocketArguments(socket, actorChangeEvent, args, 2)) {
          takeShortRest(socket, actor, actor);
        }
        break;
      case SERVER_REQUEST_EVENTS.ACTOR_CHANGE.LONG_REST:
        if (validSocketArguments(socket, actorChangeEvent, args, 2)) {
          takeLongRest(socket, actor, actor);
        }
        break;
      default:
      //TODO: Error here
    }
  }

  function applyHealthChange(socket, actor, healthChange) {
    actor
      .applyDamage(healthChange)
      .then
      // do nothing
      ();
  }

  function takeShortRest(socket, actor) {
    actor
      .shortRest({ dialog: false })
      .then
      //do nothing
      ();
  }

  function takeLongRest(socket, actor) {
    actor
      .longRest({ dialog: false })
      .then
      //do nothing
      ();
  }
}
