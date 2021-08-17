import { Server, Socket } from "socket.io";
import { actorAbilityListener } from "./actorAbilityListener";
import { actorBiographyListener } from "./actorBiographyListener";
import { actorInventoryListener } from "./actorInventoryListener";
import { actorOverviewListener } from "./actorOverviewListener";
import { actorSpellSlotListener } from "./actorSpellSlotListener";
import { actorSkillListener } from "./actorSkillListener";
import { actorCurrencyListener } from "./actorCurrencyListener";
import { actorSpellsListener } from "./actorSpellListener";

export const actorListenerWrapper = (io: Server, socket: Socket): void => {
  actorAbilityListener(io, socket);
  actorBiographyListener(io, socket);
  actorInventoryListener(io, socket);
  actorOverviewListener(io, socket);
  actorSpellSlotListener(io, socket);
  actorSkillListener(io, socket);
  actorCurrencyListener(io, socket);
  actorSpellsListener(io, socket);
};
