import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ActorSpellSlot } from "../../interfaces/actor/ActorSpellSlot";

export const actorSpellSlotListener = (io: Server, socket: Socket): void => {
  const requestActorSpellSlots = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_SPELL_SLOTS,
        actorId,
        socket.id
      );
    }
  };

  const receiveActorSpellSlots = (
    spellSlots: ActorSpellSlot[],
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.SEND.SEND_ACTOR_SPELL_SLOTS,
        JSON.stringify(spellSlots)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ACTOR.REQUEST_ACTOR_SPELL_SLOTS,
    requestActorSpellSlots
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_SPELL_SLOTS,
    receiveActorSpellSlots
  );
};
