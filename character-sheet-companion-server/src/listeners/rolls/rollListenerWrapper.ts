import { Server, Socket } from "socket.io";
import { abilityRollListener } from "./abilityRollListener";
import { skillRollListener } from "./skillRollListener";
import { itemAttackRollListener } from "./itemAttackRollListener";
import { itemDamageRollListener } from "./itemDamageRollListener";
import { itemConsumeRollListener } from "./itemConsumeRollListener";
import { itemToolRollListener } from "./itemToolRollListener";

export const rollListenerWrapper = (io: Server, socket: Socket): void => {
  abilityRollListener(io, socket);
  skillRollListener(io, socket);
  itemAttackRollListener(io, socket);
  itemDamageRollListener(io, socket);
  itemConsumeRollListener(io, socket);
  itemToolRollListener(io, socket);
};
