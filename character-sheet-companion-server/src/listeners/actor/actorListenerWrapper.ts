import { Server, Socket } from "socket.io";
import { actorAbilityListener } from "./actorAbilityListener";
import { actorDetailsListener } from "./actorDetailsListener";
import { actorInventoryListener } from "./actorInventoryListener";
import { actorAttributesListener } from "./actorAttributesListener";
import { actorSpellSlotListener } from "./actorSpellSlotListener";
import { actorSkillListener } from "./actorSkillListener";
import { actorCurrencyListener } from "./actorCurrencyListener";
import { actorSpellsListener } from "./actorSpellListener";
import { actorBaseDataListener } from "./actorBaseDataListener";
import { actorClassesListener } from "./actorClassesListener";
import { actorTraitsListener } from "./actorTraitsListener";

export const actorListenerWrapper = (io: Server, socket: Socket): void => {
  actorAbilityListener(io, socket);
  actorDetailsListener(io, socket);
  actorInventoryListener(io, socket);
  actorAttributesListener(io, socket);
  actorSpellSlotListener(io, socket);
  actorSkillListener(io, socket);
  actorCurrencyListener(io, socket);
  actorSpellsListener(io, socket);
  actorBaseDataListener(io, socket);
  actorClassesListener(io, socket);
  actorTraitsListener(io, socket);
};
