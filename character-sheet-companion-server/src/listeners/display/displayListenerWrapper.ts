import { Server, Socket } from "socket.io";
import { displayItemListener } from "./displayItemListener";
import { displayChatMessageListener } from "./displayChatMessageListener";

export const displayListenerWrapper = (io: Server, socket: Socket): void => {
  displayItemListener(io, socket);
  displayChatMessageListener(io, socket);
};
