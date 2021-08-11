import { Server, Socket } from "socket.io";
import { actorAbilityListener } from "./actorAbilityListener";
import { actorBiographyListener } from "./actorBiographyListener";
import { actorInventoryListener } from "./actorInventoryListener";
import { actorOverviewListener } from "./actorOverviewListener";
import { actorSpellSlotListener } from "./actorSpellSlotListener";

export const actorListenerWrapper = (io: Server, socket: Socket): void => {
  actorAbilityListener(io, socket);
  actorBiographyListener(io, socket);
  actorInventoryListener(io, socket);
  actorOverviewListener(io, socket);
  actorSpellSlotListener(io, socket);
};
