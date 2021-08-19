import { IOS_DATA_MAP } from "../listeners/setup/setupIosCompleteListener.js";
import { SOCKET_EVENTS } from "../constants/events.js";

export async function getBase64ImageData(url) {
  return fetch(url)
    .then((response) => response.blob())
    .then(
      (blob) =>
        new Promise((resolve, reject) => {
          const reader = new FileReader();
          reader.onloadend = () => resolve(reader.result);
          reader.onerror = reject;
          reader.readAsDataURL(blob);
        })
    );
}

export function getActorOrEmitError(socket, actorId, iosSocketId) {
  let actor = game.actors.get(actorId);
  if (actor) {
    return actor;
  }
  socket.emit(SOCKET_EVENTS.ERROR.ACTOR.NO_ACTOR_FOR_ID, actorId, iosSocketId);
}

export function removeBase64Metadata(imageData) {
  return imageData.split(",")[1];
}

export function removeHtml(text) {
  return jQuery("<p>" + text + "</p>").text();
}

export function shouldHandleHookEvent(entity) {
  if (entity) {
    let actorId = entity.data._id;
    return !!IOS_DATA_MAP.get(actorId);
  }
}
