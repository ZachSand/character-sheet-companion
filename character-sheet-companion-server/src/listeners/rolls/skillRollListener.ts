import { Server, Socket } from "socket.io";
import {
  getIosSocketFromRoom,
  getFoundrySocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { SkillRoll } from "../../interfaces/rolls/SkillRoll";

export const skillRollListener = (io: Server, socket: Socket): void => {
  const requestFoundrySkillRoll = (skillRoll: SkillRoll) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_SKILL_ROLL,
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
        SOCKET_EVENTS.SERVER.SEND_FOUNDRY_SKILL_ROLL,
        JSON.stringify(skillRoll)
      );
    }
  };

  socket.on(
    SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_SKILL_ROLL,
    requestFoundrySkillRoll
  );
  socket.on(SOCKET_EVENTS.FOUNDRY.SEND_SKILL_ROLL, receiveFoundrySkillRoll);
};
