import {
  getActorOrEmitError,
  getBase64ImageData,
  removeBase64Metadata,
} from "../../utils/commonUtilities.js";
import { SOCKET_EVENTS } from "../../constants/events.js";

export async function createAndEmitActorBaseData(socket, actorId, iosSocketId) {
  let actor = getActorOrEmitError(socket, actorId, iosSocketId);
  if (actor) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_BASE_DATA,
      {
        id: actor.data._id,
        name: actor.data.name,
        image: await getBase64ImageData(actor.data.img).then((imageData) => {
          return removeBase64Metadata(imageData);
        }),
      },
      iosSocketId
    );
  }
}
