import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ActorSpells } from "../../interfaces/actor/ActorSpells";

export const actorSpellsListener = (io: Server, socket: Socket): void => {
  const requestActorSpells = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_SPELLS,
        actorId,
        socket.id
      );
    }
  };

  const receiveActorSpells = (spells: ActorSpells, iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.SEND.SEND_ACTOR_SPELLS,
        JSON.stringify(spells)
      );
    }
  };

  socket.on(SOCKET_EVENTS.IOS.ACTOR.REQUEST_ACTOR_SPELLS, requestActorSpells);
  socket.on(SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_SPELLS, receiveActorSpells);
};
