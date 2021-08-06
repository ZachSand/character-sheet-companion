import { SOCKET_EVENTS } from "../../events/events.js";
import { createAndEmitAbilityRoll } from "./abilityRollListener.js";
import { createAndEmitSkillRoll } from "./skillRollListener.js";
import { createAndEmitAttackRoll } from "./itemAttackRollListener.js";
import { createAndEmitItemDamageRoll } from "./itemDamageRollListener.js";
import { createAndEmitItemConsumeRoll } from "./itemConsumeRollListener.js";
import { createAndEmitItemToolRoll } from "./itemToolRollListener.js";
import { createAndEmitInitiativeRoll } from "./initiativeRollListener.js";

export function addRollListeners(socket) {
  socket.on(
    SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ABILITY_ROLL,
    (abilityRoll, iosSocketId) => {
      createAndEmitAbilityRoll(socket, abilityRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_SKILL_ROLL,
    (skillRoll, iosSocketId) => {
      createAndEmitSkillRoll(socket, skillRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ITEM_ATTACK_ROLL,
    (itemAttackRoll, iosSocketId) => {
      createAndEmitAttackRoll(socket, itemAttackRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL,
    (itemDamageRoll, iosSocketId) => {
      createAndEmitItemDamageRoll(socket, itemDamageRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ITEM_CONSUME_ROLL,
    (itemConsumeRoll, iosSocketId) => {
      createAndEmitItemConsumeRoll(socket, itemConsumeRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_ITEM_TOOL_ROLL,
    (itemToolRoll, iosSocketId) => {
      createAndEmitItemToolRoll(socket, itemToolRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.REQUEST_FOUNDRY_INITIATIVE_ROLL,
    (initiativeRoll, iosSocketId) => {
      createAndEmitInitiativeRoll(socket, initiativeRoll, iosSocketId);
    }
  );
}
