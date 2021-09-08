import { Server, Socket } from "socket.io";
import { getFoundrySocketFromRoom } from "../utilities/socketUtilities";
import { ServerSocketRequestEvents } from "../events/socket/ServerSocketRequestEvents";
import { IosSocketEvents } from "../events/socket/IosSocketEvents";

export const actorChangeEventsHandler = (io: Server, socket: Socket): void => {
  const requestActorHealthChange = (actorId: string, healthChange: number) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        ServerSocketRequestEvents.Instance.SERVER_EVENTS.ACTOR_CHANGE
          .HEALTH_CHANGE,
        actorId,
        healthChange,
        socket.id
      );
    }
  };

  const requestShortRest = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        ServerSocketRequestEvents.Instance.SERVER_EVENTS.ACTOR_CHANGE
          .SHORT_REST,
        actorId,
        socket.id
      );
    }
  };

  const requestLongRest = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        ServerSocketRequestEvents.Instance.SERVER_EVENTS.ACTOR_CHANGE.LONG_REST,
        actorId,
        socket.id
      );
    }
  };

  socket.on(
    IosSocketEvents.Instance.IOS_EVENTS.ACTOR_CHANGE.HEALTH_CHANGE,
    requestActorHealthChange
  );
  socket.on(
    IosSocketEvents.Instance.IOS_EVENTS.ACTOR_CHANGE.SHORT_REST,
    requestShortRest
  );
  socket.on(
    IosSocketEvents.Instance.IOS_EVENTS.ACTOR_CHANGE.LONG_REST,
    requestLongRest
  );
};
