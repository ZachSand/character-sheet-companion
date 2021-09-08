import {
  getValidActor,
  validSocketArguments,
} from "../../utils/commonUtilities.js";
import { ServerSocketRequestEvents } from "../../events/socket/ServerSocketRequestEvents.js";
import { CORE_EVENTS } from "../../events/coreEvents.js";

export function handleActorChangeEvents(socket) {
  Object.values(
    ServerSocketRequestEvents.Instance.SERVER_EVENTS.ACTOR_CHANGE
  ).forEach((actorChangeEvent) => {
    socket.on(
      ServerSocketRequestEvents.Instance.SERVER_EVENTS.ACTOR + actorChangeEvent,
      (...args) => {
        handleActorChangeEvent(socket, actorChangeEvent, args);
      }
    );
  });
}

export function handleActorChangeEvent(socket, event, args) {
  if (!args || args.length < 2) {
    //TODO: Some error
  }

  let iosSocketId = args[args.length - 1];
  let actor = getValidActor(socket, actorId, iosSocketId);

  if (actor) {
    switch (_.startCase(_.camelCase(event))) {
      case CORE_EVENTS.HEALTH_CHANGE:
        if (validSocketArguments(socket, event, args, 3)) {
          applyHealthChange(socket, actor, args[1], iosSocketId);
        }
        break;
      case CORE_EVENTS.SHORT_REST:
        if (validSocketArguments(socket, event, args, 2)) {
          takeShortRest(socket, actor, actor);
        }
        break;
      case CORE_EVENTS.LONG_REST:
        if (validSocketArguments(socket, event, args, 2)) {
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
        .shortRest({dialog: false})
        .then
        //do nothing
        ();
  }

  function takeLongRest(socket, actor) {
    actor
        .longRest({dialog: false})
        .then
        //do nothing
        ();
  }
}
