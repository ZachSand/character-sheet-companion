import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../../utilities/SocketUtilities";
import { SOCKET_EVENTS } from "../../constants/events";
import { ActorSkill } from "../../interfaces/actor/ActorSkill";

export const actorSkillListener = (io: Server, socket: Socket): void => {
  const requestActorSkills = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.REQUEST.REQUEST_ACTOR_SKILLS,
        actorId,
        socket.id
      );
    }
  };

  const receiveActorSkills = (skills: ActorSkill[], iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        SOCKET_EVENTS.SERVER.ACTOR.SEND.SEND_ACTOR_SKILLS,
        JSON.stringify(skills)
      );
    }
  };

  socket.on(SOCKET_EVENTS.IOS.ACTOR.REQUEST_ACTOR_SKILLS, requestActorSkills);
  socket.on(SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_SKILLS, receiveActorSkills);
};
