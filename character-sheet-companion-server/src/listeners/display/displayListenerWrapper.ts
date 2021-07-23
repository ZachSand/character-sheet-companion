import { Server, Socket } from "socket.io";
import { displayItemListener } from "./displayItemListener";

export const displayListenerWrapper = (io: Server, socket: Socket): void => {
  displayItemListener(io, socket);
};
