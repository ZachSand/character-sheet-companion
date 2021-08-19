import { SOCKET_EVENTS } from "../../constants/events.js";
import { getActorOrEmitError } from "../../utils/commonUtilities.js";

export function createAndEmitActorCurrency(socket, actorId, iosSocketId) {
  let actor = getActorOrEmitError(socket, actorId, iosSocketId);
  if (actor) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_CURRENCY,
      {
        copper: actor.data.data.currency.cp,
        silver: actor.data.data.currency.sp,
        electrum: actor.data.data.currency.cp,
        gold: actor.data.data.currency.gp,
        platinum: actor.data.data.currency.pp,
      },
      iosSocketId
    );
  }
}
