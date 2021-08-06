import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { SpellDialog } from "../../interfaces/display/SpellDialog";

export const spellDialogListener = (io: Server, socket: Socket): void => {
  const requestFoundrySpellDialog = (actorId: string, spellId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_SPELL_DIALOG,
        actorId,
        spellId,
        socket.id
      );
    }
  };

  const receiveFoundrySpellDialog = (
    spellDialogs: SpellDialog[],
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_ABILITY_ROLL,
        JSON.stringify(spellDialogs)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_SPELL_DIALOG,
    requestFoundrySpellDialog
  );
  socket.on(SOCKET_EVENTS.FOUNDRY.SEND_SPELL_DIALOG, receiveFoundrySpellDialog);
};
