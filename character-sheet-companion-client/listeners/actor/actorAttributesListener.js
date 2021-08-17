import { SOCKET_EVENTS } from "../../constants/events.js";

export function createAndEmitActorAttributes(socket, actorId, iosSocketId) {
  let actor = game.actors.get(actorId);
  if (actor) {
    let attributes = actor.data.data.attributes;
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.ACTOR.SEND_ACTOR_ATTRIBUTES,
      {
        deathSaves: {
          success: attributes.death.success,
          failures: attributes.death.failures,
        },
        encumbrance: {
          currentValue: attributes.encumbrance.value,
          maxValue: attributes.encumbrance.max,
        },
        hitDice: attributes.hd,
        inspiration: attributes.inspiration,
        exhaustion: attributes.exhaustion,
        movement: {
          burrow: attributes.movement.burrow,
          climb: attributes.movement.climb,
          fly: attributes.movement.fly,
          hover: attributes.movement.hover,
          swim: attributes.movement.swim,
          units: attributes.movement.units,
          walk: attributes.movement.walk,
        },
        armorClass: attributes.ac.value,
        currentHealth: attributes.hp.value,
        maxHealth: attributes.hp.max,
        proficiencyBonus: attributes.prof,
        initiativeBonus: attributes.init.total,
        spellDiceCheck: attributes.spelldc,
        spellCasting: attributes.spellcasting,
      },
      iosSocketId
    );
  }
}
