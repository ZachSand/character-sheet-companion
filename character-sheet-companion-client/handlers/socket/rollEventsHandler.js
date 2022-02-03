import { SERVER_REQUEST_EVENTS } from "../../events/serverRequestEvents.js";
import { FOUNDRY_EVENTS } from "../../events/foundryEvents.js";

export function handleRollEvents(socket) {
  Object.values(SERVER_REQUEST_EVENTS.ROLL).forEach((rollEvent) => {
    socket.on(rollEvent, (roll, iosSocketId) => {
      handleRollEvent(rollEvent, socket, roll, iosSocketId);
    });
  });
}

export function handleRollEvent(rollEvent, socket, roll, iosSocketId) {
  let rollObj = JSON.parse(roll);
  let actor = game.actors.get(rollObj.actorId);

  let item = undefined;
  if (actor && rollObj.itemId) {
    item = actor.items.get(rollObj.itemId);
    if (!item) {
      //TODO: Some error
    }
  }

  if (rollObj && actor) {
    switch (rollEvent) {
      case SERVER_REQUEST_EVENTS.ROLL.ABILITY:
        createAndEmitAbilityRoll(socket, rollObj, actor, iosSocketId);
        break;
      case SERVER_REQUEST_EVENTS.ROLL.DEATH_SAVE:
        createAndEmitDeathSaveRoll(socket, rollObj, actor, iosSocketId);
        break;
      case SERVER_REQUEST_EVENTS.ROLL.HIT_DIE:
        createAndEmitHitDieRoll(socket, rollObj, actor, iosSocketId);
        break;
      case SERVER_REQUEST_EVENTS.ROLL.INITIATIVE:
        createAndEmitInitiativeRoll(socket, rollObj, actor, iosSocketId);
        break;
      case SERVER_REQUEST_EVENTS.ROLL.ITEM_ATTACK:
        createAndEmitItemAttackRoll(socket, rollObj, item, iosSocketId);
        break;
      case SERVER_REQUEST_EVENTS.ROLL.ITEM_CONSUME:
        createAndEmitItemConsumeRoll(socket, rollObj, item, iosSocketId);
        break;
      case SERVER_REQUEST_EVENTS.ROLL.ITEM_DAMAGE:
        createAndEmitItemDamageRoll(socket, rollObj, item, iosSocketId);
        break;
      case SERVER_REQUEST_EVENTS.ROLL.ITEM_TOOL:
        createAndEmitItemToolRoll(socket, rollObj, item, iosSocketId);
        break;
      case SERVER_REQUEST_EVENTS.ROLL.SKILL:
        createAndEmitSkillRoll(socket, rollObj, actor, iosSocketId);
        break;
      default:
      //TODO: Some error
    }
  } else {
    //TODO: Some error
  }

  function getCommonRollOptions(roll) {
    return {
      advantage: roll.advantage,
      disadvantage: roll.disadvantage,
      fastForward: true,
    };
  }

  function handleRollResult(socket, event, roll, rollResult, iosSocketId) {
    roll.result = roll._total;
    socket.emit(event, roll, iosSocketId);
  }

  function createAndEmitAbilityRoll(socket, abilityRoll, iosSocketId) {
    if (abilityRoll.isSave) {
      actor
        .rollAbilitySave(abilityRoll.ability, getCommonRollOptions(abilityRoll))
        .then((rollResult) =>
          handleRollResult(
            socket,
            FOUNDRY_EVENTS.ROLL.ABILITY,
            abilityRoll,
            rollResult,
            iosSocketId
          )
        );
    } else {
      actor
        .rollAbilityTest(abilityRoll.ability, getCommonRollOptions(abilityRoll))
        .then((rollResult) =>
          handleRollResult(
            socket,
            FOUNDRY_EVENTS.ROLL.ABILITY,
            abilityRoll,
            rollResult,
            iosSocketId
          )
        );
    }
  }

  function createAndEmitDeathSaveRoll(
    socket,
    deathSaveRoll,
    actor,
    iosSocketId
  ) {
    actor
      .rollDeathSave(getCommonRollOptions(deathSaveRoll))
      .then((rollResult) =>
        handleRollResult(
          socket,
          FOUNDRY_EVENTS.ROLL.DEATH_SAVE,
          deathSaveRoll,
          rollResult,
          iosSocketId
        )
      );
  }

  function createAndEmitHitDieRoll(socket, hitDieRoll, actor, iosSocketId) {
    actor
      .rollHitDie(hitDieRoll.hitDie, { dialog: false })
      .then((rollResult) =>
        handleRollResult(
          socket,
          FOUNDRY_EVENTS.ROLL.HIT_DIE,
          hitDieRoll,
          rollResult,
          iosSocketId
        )
      );
  }

  function createAndEmitInitiativeRoll(
    socket,
    initiativeRoll,
    actor,
    iosSocketId
  ) {
    //TODO: Check for if combat is started and actor is involved
    actor
      .rollInitiative()
      .then((rollResult) =>
        handleRollResult(
          socket,
          FOUNDRY_EVENTS.ROLL.INITIATIVE,
          initiativeRoll,
          rollResult,
          iosSocketId
        )
      );
  }

  function createAndEmitItemAttackRoll(
    socket,
    itemAttackRoll,
    item,
    iosSocketId
  ) {
    item
      .rollAttack(getCommonRollOptions(itemAttackRoll))
      .then((rollResult) =>
        handleRollResult(
          socket,
          FOUNDRY_EVENTS.ROLL.ITEM_ATTACK,
          itemAttackRoll,
          rollResult,
          iosSocketId
        )
      );
  }

  function createAndEmitItemConsumeRoll(
    socket,
    itemConsumeRoll,
    item,
    iosSocketId
  ) {
    if (itemConsumeRoll.consume) {
      // Consumes usage of item if it has any left
      item.roll({ configureDialog: false, chatMessage: false });
    }

    item
      .rollDamage({
        critical: false,
        versatile: false,
        options: {
          fastForward: true,
        },
      })
      .then((rollResult) =>
        handleRollResult(
          socket,
          FOUNDRY_EVENTS.ROLL.ITEM_CONSUME,
          itemConsumeRoll,
          rollResult,
          iosSocketId
        )
      );
  }

  function createAndEmitItemDamageRoll(
    socket,
    itemDamageRoll,
    item,
    iosSocketId
  ) {
    item
      .rollDamage({
        critical: itemDamageRoll.critical,
        versatile: itemDamageRoll.versatile,
        options: {
          fastForward: true,
        },
      })
      .then((rollResult) =>
        handleRollResult(
          socket,
          FOUNDRY_EVENTS.ROLL.ITEM_DAMAGE,
          itemDamageRoll,
          rollResult,
          iosSocketId
        )
      );
  }

  function createAndEmitItemToolRoll(socket, itemToolRoll, item, iosSocketId) {
    item
      .rollToolCheck(getCommonRollOptions(itemToolRoll))
      .then((rollResult) =>
        handleRollResult(
          socket,
          FOUNDRY_EVENTS.ROLL.ITEM_TOOL,
          itemToolRoll,
          rollResult,
          iosSocketId
        )
      );
  }

  function createAndEmitSkillRoll(socket, skillRoll, actor, iosSocketId) {
    actor
      .rollSkill(skillRoll.skill, getCommonRollOptions(skillRoll))
      .then((rollResult) =>
        handleRollResult(
          socket,
          FOUNDRY_EVENTS.ROLL.SKILL,
          skillRoll,
          rollResult,
          iosSocketId
        )
      );
  }
}
