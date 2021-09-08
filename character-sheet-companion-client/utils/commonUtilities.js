import { IOS_DATA_MAP } from "../handlers/socket/setupEventsHandler.js";

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

export function validSocketArguments(socket, event, args, expected) {
  if (args && args.length === expected) {
    return true;
  }

  //TODO: Some error here
  socket.emit("SomeError: " + event + args + expected);
}

export function getValidActor(socket, actorId, iosSocketId) {
  let actor = game.actors.get(actorId);
  if (actor) {
    return actor;
  }
  //TODO: Some error
  socket.emit("Some error");
}

export function removeBase64Metadata(imageData) {
  return imageData.split(",")[1];
}

export function removeHtml(text) {
  return jQuery("<p>" + text + "</p>").text();
}

export function shouldHandleHookEvent(actorId) {
  if (actorId) {
    return !!IOS_DATA_MAP.get(actorId);
  }
}
