import { Server, Socket } from "socket.io";
import { BASE_EVENTS } from "../events/baseEvents";
import {
  getFoundrySocketFromRoom,
  getIosSocketFromRoom,
} from "../utilities/socketUtilities";
import { ServerSocketRequestEvents } from "../events/socket/ServerSocketRequestEvents";
import { ServerSocketSendEvents } from "../events/socket/ServerSocketSendEvents";
import { IosSocketEvents } from "../events/socket/IosSocketEvents";
import { FoundrySocketEvents } from "../events/socket/FoundrySocketEvents";
import {
  ActorAbilities,
  ActorAttributes,
  ActorBaseData,
  ActorClasses,
  ActorCurrency,
  ActorDetails,
  ActorInventory,
  ActorSkills,
  ActorSpells,
  ActorSpellSlots,
  ActorTraits,
} from "../models/ActorModels";

export const actorEventsHandler = (io: Server, socket: Socket): void => {
  genericActorListener<ActorAbilities>(BASE_EVENTS.ACTOR.ABILITIES, io, socket);
  genericActorListener<ActorDetails>(BASE_EVENTS.ACTOR.DETAILS, io, socket);
  genericActorListener<ActorSkills>(BASE_EVENTS.ACTOR.SKILLS, io, socket);
  genericActorListener<ActorCurrency>(BASE_EVENTS.ACTOR.CURRENCY, io, socket);
  genericActorListener<ActorSpells>(BASE_EVENTS.ACTOR.SPELLS, io, socket);
  genericActorListener<ActorBaseData>(BASE_EVENTS.ACTOR.BASE_DATA, io, socket);
  genericActorListener<ActorClasses>(BASE_EVENTS.ACTOR.CLASSES, io, socket);
  genericActorListener<ActorTraits>(BASE_EVENTS.ACTOR.TRAITS, io, socket);
  genericActorListener<ActorInventory>(BASE_EVENTS.ACTOR.INVENTORY, io, socket);

  genericActorListener<ActorAttributes>(
    BASE_EVENTS.ACTOR.ATTRIBUTES,
    io,
    socket
  );

  genericActorListener<ActorSpellSlots>(
    BASE_EVENTS.ACTOR.SPELL_SLOTS,
    io,
    socket
  );
};

const genericActorListener = <ModelType>(
  baseEvent: string,
  io: Server,
  socket: Socket
): void => {
  const requestFoundryData = (actorId: string) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        ServerSocketRequestEvents.Instance.getFromBaseEvent(baseEvent),
        actorId,
        socket.id
      );
    }
  };

  const receiveFoundryData = (model: ModelType, iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        ServerSocketSendEvents.Instance.getFromBaseEvent(baseEvent),
        JSON.stringify(model)
      );
    }
  };

  socket.on(
    IosSocketEvents.Instance.getFromBaseEvent(baseEvent),
    requestFoundryData
  );
  socket.on(
    FoundrySocketEvents.Instance.getFromBaseEvent(baseEvent),
    receiveFoundryData
  );
};
