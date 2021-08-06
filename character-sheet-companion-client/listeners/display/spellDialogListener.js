import { SOCKET_EVENTS } from "../../events/events.js";

export function createAndEmitSpellDialog(
  socket,
  actorId,
  spellId,
  iosSocketId
) {
  let actor = game.actors.get(actorId);
  let spell = actor.items.get(spellId);
  if (actor && spell) {
    let spellDialogsToRespond = [];
    let spellDialog = game.dnd5e.applications.AbilityUseDialog._getSpellData(
      actor,
      spell,
      {}
    );
    if (spellDialog.spellLevels && spellDialog.spellLevels.length) {
      for (let dialog of spellDialog.spellLevels) {
        spellDialogsToRespond.push({
          canCast: dialog.canCast,
          hasSlots: dialog.hasSlots,
          label: dialog.label,
          level: dialog.level,
        });
      }

      socket.emit(
        SOCKET_EVENTS.FOUNDRY.SEND_SPELL_DIALOG,
        spellDialogsToRespond,
        iosSocketId
      );
    }
  }
}
