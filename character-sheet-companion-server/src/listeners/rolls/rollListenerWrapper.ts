import { Server, Socket } from "socket.io";
import { abilityRollListener } from "./abilityRollListener";
import { skillRollListener } from "./skillRollListener";
import { itemAttackRollListener } from "./itemAttackRollListener";
import {itemDamageRollListener} from "./itemDamageRollListener";

export const rollListenerWrapper = (io: Server, socket: Socket): void => {
  abilityRollListener(io, socket);
  skillRollListener(io, socket);
  itemAttackRollListener(io, socket);
  itemDamageRollListener(io, socket);
};
