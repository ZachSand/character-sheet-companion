import { SOCKET_EVENTS } from "../../constants/events.js";
import { createAndEmitAbilityRoll } from "./rollAbilityListener.js";
import { createAndEmitSkillRoll } from "./skillRollListener.js";
import { createAndEmitAttackRoll } from "./rollItemAttackListener.js";
import { createAndEmitItemDamageRoll } from "./rollItemDamageListener.js";
import { createAndEmitItemConsumeRoll } from "./rollItemConsumeListener.js";
import { createAndEmitItemToolRoll } from "./rollItemToolListener.js";
import { createAndEmitInitiativeRoll } from "./rollInitiativeListener.js";
import { createAndEmitDeathSaveRoll } from "./rollDeathSaveListener.js";
import { createAndEmitHitDieRoll } from "./rollHitDieListener.js";

export function rollListenerWrapper(socket) {
  socket.on(
    SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_ABILITY_ROLL,
    (abilityRoll, iosSocketId) => {
      createAndEmitAbilityRoll(socket, abilityRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_SKILL_ROLL,
    (skillRoll, iosSocketId) => {
      createAndEmitSkillRoll(socket, skillRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_ITEM_ATTACK_ROLL,
    (itemAttackRoll, iosSocketId) => {
      createAndEmitAttackRoll(socket, itemAttackRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL,
    (itemDamageRoll, iosSocketId) => {
      createAndEmitItemDamageRoll(socket, itemDamageRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_ITEM_CONSUME_ROLL,
    (itemConsumeRoll, iosSocketId) => {
      createAndEmitItemConsumeRoll(socket, itemConsumeRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_ITEM_TOOL_ROLL,
    (itemToolRoll, iosSocketId) => {
      createAndEmitItemToolRoll(socket, itemToolRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_INITIATIVE_ROLL,
    (initiativeRoll, iosSocketId) => {
      createAndEmitInitiativeRoll(socket, initiativeRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_DEATH_SAVE_ROLL,
    (deathSaveRoll, iosSocketId) => {
      createAndEmitDeathSaveRoll(socket, deathSaveRoll, iosSocketId);
    }
  );

  socket.on(
    SOCKET_EVENTS.SERVER.ROLL.REQUEST.REQUEST_FOUNDRY_HIT_DIE_ROLL,
    (hitDieRoll, iosSocketId) => {
      createAndEmitHitDieRoll(socket, hitDieRoll, iosSocketId);
    }
  );
}
