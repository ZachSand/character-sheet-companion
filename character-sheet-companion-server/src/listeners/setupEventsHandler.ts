import { Server, Socket } from "socket.io";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../utilities/socketUtilities";
import { ServerSocketRequestEvents } from "../events/socket/ServerSocketRequestEvents";
import { ServerSocketSendEvents } from "../events/socket/ServerSocketSendEvents";
import { IosSocketEvents } from "../events/socket/IosSocketEvents";
import { FoundrySocketEvents } from "../events/socket/FoundrySocketEvents";
import Logger from "../loaders/logger";
import { ErrorSocketEvents } from "../events/socket/ErrorSocketEvents";
import {
  SetupUserAuth,
  SetupUsers,
  SetupWorldData,
} from "../models/SetupModels";

export const setupEventsHandler = (io: Server, socket: Socket): void => {
  const getFoundryUsers = () => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        ServerSocketRequestEvents.Instance.SERVER_EVENTS.SETUP.WORLD_USERS,
        socket.id
      );
    }
  };

  const receiveFoundryUsers = (users: SetupUsers, iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        ServerSocketSendEvents.Instance.SERVER_EVENTS.SETUP.WORLD_USERS,
        JSON.stringify(users)
      );
    }
  };

  const getWorldData = () => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        ServerSocketRequestEvents.Instance.SERVER_EVENTS.SETUP.WORLD_DATA,
        socket.id
      );
    }
  };

  const receiveWorldData = (world: SetupWorldData, iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        ServerSocketSendEvents.Instance.SERVER_EVENTS.SETUP.WORLD_DATA,
        JSON.stringify(world)
      );
    }
  };

  const foundryJoin = (roomId: string) => {
    Logger.debug(`Foundry client connecting to room: ${roomId}`);
    socket.join(roomId);
    socket.data.foundry = true;
    socket.data.ios = false;
    socket.data.roomId = roomId;
  };

  const iosJoin = (roomId: string) => {
    const clients = io.sockets.adapter.rooms.get(roomId);
    if (clients) {
      const numClients = clients ? clients.size : 0;
      if (numClients == 0) {
        handleEmptyRoomForIos();
      } else {
        handleIosJoinRoom();
      }
    } else {
      handleIosNoRoomToJoin();
    }

    function handleEmptyRoomForIos() {
      Logger.error(
        `iOS client attempted to connect to room ${roomId} but there wasn't another socket in the room`
      );
      socket.emit(
        ErrorSocketEvents.Instance.ERROR_EVENTS.SETUP.ROOM_EMPTY,
        "No other sockets in room to join with"
      );
    }

    function handleIosJoinRoom() {
      Logger.debug(`iOS client connecting to room: ${roomId}`);
      socket.join(roomId);
      socket.data.foundry = false;
      socket.data.ios = true;
      socket.data.roomId = roomId;
      socket.emit(
        ServerSocketSendEvents.Instance.SERVER_EVENTS.SETUP.JOINED_ROOM
      );
    }

    function handleIosNoRoomToJoin() {
      Logger.error(`Couldn't determine client count for room: ${roomId}`);
      socket.emit(
        ErrorSocketEvents.Instance.ERROR_EVENTS.SETUP.ROOM_EMPTY,
        `Couldn't determine client count for room: ${roomId}`
      );
    }
  };

  const receiveIosSetupComplete = (actorId: string, userId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        ServerSocketSendEvents.Instance.SERVER_EVENTS.SETUP.SETUP_COMPLETE,
        actorId,
        userId,
        socket.id
      );
    }
  };

  const getUserAuthentication = (setupUserAuth: SetupUserAuth) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        ServerSocketRequestEvents.Instance.SERVER_EVENTS.SETUP.WORLD_USER_AUTH,
        setupUserAuth,
        socket.id
      );
    }
  };

  const receiveUserAuthentication = (
    setupUserAuth: SetupUserAuth,
    iosSocketId: string
  ) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        ServerSocketSendEvents.Instance.SERVER_EVENTS.SETUP.WORLD_USER_AUTH,
        JSON.stringify(setupUserAuth)
      );
    }
  };

  socket.on(
    IosSocketEvents.Instance.IOS_EVENTS.SETUP.WORLD_USERS,
    getFoundryUsers
  );

  socket.on(
    FoundrySocketEvents.Instance.FOUNDRY_EVENTS.SETUP.WORLD_USERS,
    receiveFoundryUsers
  );

  socket.on(
    IosSocketEvents.Instance.IOS_EVENTS.SETUP.WORLD_USER_AUTH,
    getUserAuthentication
  );

  socket.on(
    FoundrySocketEvents.Instance.FOUNDRY_EVENTS.SETUP.WORLD_USER_AUTH,
    receiveUserAuthentication
  );

  socket.on(
    IosSocketEvents.Instance.IOS_EVENTS.SETUP.SETUP_COMPLETE,
    receiveIosSetupComplete
  );

  socket.on(
    FoundrySocketEvents.Instance.FOUNDRY_EVENTS.SETUP.JOIN_ROOM,
    foundryJoin
  );

  socket.on(IosSocketEvents.Instance.IOS_EVENTS.SETUP.JOIN_ROOM, iosJoin);

  socket.on(IosSocketEvents.Instance.IOS_EVENTS.SETUP.WORLD_DATA, getWorldData);

  socket.on(
    FoundrySocketEvents.Instance.FOUNDRY_EVENTS.SETUP.WORLD_DATA,
    receiveWorldData
  );
};
