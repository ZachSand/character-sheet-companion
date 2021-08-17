import { setupListenerWrapper } from "./setup/setupListenerWrapper.js";
import { displayListenerWrapper } from "./display/displayListenerWrapper.js";
import { rollListenerWrapper } from "./rolls/rollListenerWrapper.js";
import { actorListenerWrapper } from "./actor/actorListenerWrapper.js";

export function socketListenerWrapper(socket) {
  setupListenerWrapper(socket);
  displayListenerWrapper(socket);
  rollListenerWrapper(socket);
  actorListenerWrapper(socket);
}
