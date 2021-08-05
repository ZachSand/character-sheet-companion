import { Server, Socket } from "socket.io";
import { displayItemListener } from "./displayItemListener";
import { chatMessageListener } from "./chatMessageListener";

export const displayListenerWrapper = (io: Server, socket: Socket): void => {
  displayItemListener(io, socket);
  chatMessageListener(io, socket);
};
