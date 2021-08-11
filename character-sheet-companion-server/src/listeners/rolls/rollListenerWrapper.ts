import { Server, Socket } from "socket.io";
import { rollAbilityListener } from "./rollAbilityListener";
import { rollSkillListener } from "./rollSkillListener";
import { rollItemAttackListener } from "./rollItemAttackListener";
import { rollItemDamageListener } from "./rollItemDamageListener";
import { rollItemConsumeListener } from "./rollItemConsumeListener";
import { rollItemToolListener } from "./rollItemToolListener";
import { rollInitiativeListener } from "./rollInitiativeListener";

export const rollListenerWrapper = (io: Server, socket: Socket): void => {
  rollAbilityListener(io, socket);
  rollSkillListener(io, socket);
  rollItemAttackListener(io, socket);
  rollItemDamageListener(io, socket);
  rollItemConsumeListener(io, socket);
  rollItemToolListener(io, socket);
  rollInitiativeListener(io, socket);
};
