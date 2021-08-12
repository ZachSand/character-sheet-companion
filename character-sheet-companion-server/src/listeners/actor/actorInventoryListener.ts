import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ActorInventory } from "../../interfaces/actor/ActorInventory";

export const actorInventoryListener = (io: Server, socket: Socket): void => {
  const requestActorInventory = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_INVENTORY,
        actorId,
        socket.id
      );
    }
  };

  const receiveActorInventory = (
    inventory: ActorInventory,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.SEND.SEND_ACTOR_INVENTORY,
        JSON.stringify(inventory)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ACTOR.REQUEST_ACTOR_INVENTORY,
    requestActorInventory
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_INVENTORY,
    receiveActorInventory
  );
};
