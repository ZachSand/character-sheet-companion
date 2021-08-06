import { Server, Socket } from "socket.io";
import { displayItemListener } from "./displayItemListener";
import { chatMessageListener } from "./chatMessageListener";
import {spellDialogListener} from "./spellDialogListener";

export const displayListenerWrapper = (io: Server, socket: Socket): void => {
  displayItemListener(io, socket);
  chatMessageListener(io, socket);
  spellDialogListener(io, socket);
};
