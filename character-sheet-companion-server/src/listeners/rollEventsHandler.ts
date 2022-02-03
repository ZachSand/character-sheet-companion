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
  RollAbility,
  RollDeathSave,
  RollHitDie,
  RollInitiative,
  RollItemAttack,
  RollItemConsume,
  RollItemDamage,
  RollItemTool,
  RollSkill,
} from "../models/RollModels";

export const rollEventsHandler = (io: Server, socket: Socket): void => {
  genericRollListener<RollAbility>(BASE_EVENTS.ROLL.ABILITY, io, socket);
  genericRollListener<RollSkill>(BASE_EVENTS.ROLL.SKILL, io, socket);
  genericRollListener<RollItemAttack>(BASE_EVENTS.ROLL.ITEM_ATTACK, io, socket);
  genericRollListener<RollItemDamage>(BASE_EVENTS.ROLL.ITEM_DAMAGE, io, socket);
  genericRollListener<RollDeathSave>(BASE_EVENTS.ROLL.DEATH_SAVE, io, socket);
  genericRollListener<RollHitDie>(BASE_EVENTS.ROLL.HIT_DIE, io, socket);
  genericRollListener<RollInitiative>(BASE_EVENTS.ROLL.INITIATIVE, io, socket);
  genericRollListener<RollItemTool>(BASE_EVENTS.ROLL.ITEM_TOOL, io, socket);
  genericRollListener<RollItemConsume>(
    BASE_EVENTS.ROLL.ITEM_CONSUME,
    io,
    socket
  );
};

const genericRollListener = <ModelType>(
  baseEvent: string,
  io: Server,
  socket: Socket
): void => {
  const requestRoll = (rollModel: ModelType) => {
    const foundrySocket = getFoundrySocketFromRoom(io, socket);
    if (foundrySocket) {
      foundrySocket.emit(
        ServerSocketRequestEvents.Instance.getFromBaseEvent(baseEvent),
        rollModel,
        socket.id
      );
    }
  };

  const receiveRollResult = (rollModel: ModelType, iosSocketId: string) => {
    const iosSocket = getIosSocketFromRoom(io, socket, iosSocketId);
    if (iosSocket) {
      iosSocket.emit(
        ServerSocketSendEvents.Instance.getFromBaseEvent(baseEvent),
        JSON.stringify(rollModel)
      );
    }
  };

  socket.on(IosSocketEvents.Instance.getFromBaseEvent(baseEvent), requestRoll);
  socket.on(
    FoundrySocketEvents.Instance.getFromBaseEvent(baseEvent),
    receiveRollResult
  );
};
