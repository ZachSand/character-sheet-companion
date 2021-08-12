import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { SkillRoll } from "../../interfaces/rolls/SkillRoll";

export const rollSkillListener = (io: Server, socket: Socket): void => {
  const requestFoundrySkillRoll = (skillRoll: SkillRoll) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_SKILL_ROLL,
        skillRoll,
        socket.id
      );
    }
  };

  const receiveFoundrySkillRoll = (
    skillRoll: SkillRoll,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ROLL.SEND.SEND_FOUNDRY_SKILL_ROLL,
        JSON.stringify(skillRoll)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.ROLL.REQUEST_FOUNDRY_SKILL_ROLL,
    requestFoundrySkillRoll
  );
  socket.on(
    SOCKET_EVENTS.FOUNDRY.ROLL.SEND_SKILL_ROLL,
    receiveFoundrySkillRoll
  );
};
