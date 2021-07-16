import { Server, Socket } from "socket.io";
import { getSocketFromRoom } from "../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../constants/events";
import { SkillRoll } from "../interfaces/SkillRoll";

export const foundrySkillRollListener = (io: Server, socket: Socket): void => {
  const requestFoundrySkillRoll = (skillRoll: SkillRoll) => {
    const foundrySocket = getSocketFromRoom(io, socket, true);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_SKILL_ROLL,
        skillRoll
      );
    }
  };

  const receiveFoundrySkillRoll = (rollResult: number) => {
    const iosSocket = getSocketFromRoom(io, socket, false);
    if (iosSocket) {
      iosSocket.emit(SOCKET_EVENTS.SERVER.SEND_FOUNDRY_SKILL_ROLL, rollResult);
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_SKILL_ROLL,
    requestFoundrySkillRoll
  );
  socket.on(SOCKET_EVENTS.FOUNDRY.SEND_SKILL_ROLL, receiveFoundrySkillRoll);
};
