import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ActorCurrency } from "../../interfaces/actor/ActorCurrency";

export const actorCurrencyListener = (io: Server, socket: Socket): void => {
  const requestActorCurrency = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_CURRENCY,
        actorId,
        socket.id
      );
    }
  };

  const receiveActorCurrency = (
    currency: ActorCurrency,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.SEND.SEND_ACTOR_CURRENCY,
        JSON.stringify(currency)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ACTOR.REQUEST_ACTOR_CURRENCY,
    requestActorCurrency
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_CURRENCY,
    receiveActorCurrency
  );
};
