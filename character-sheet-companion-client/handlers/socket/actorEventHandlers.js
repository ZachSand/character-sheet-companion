import { ServerSocketRequestEvents } from "../../events/socket/ServerSocketRequestEvents.js";
import {
  getBase64ImageData,
  getValidActor,
  removeBase64Metadata,
  removeHtml,
} from "../../utils/commonUtilities.js";
import { CORE_EVENTS } from "../../events/coreEvents.js";

export function handleActorEvents(socket) {
  Object.values(ServerSocketRequestEvents.Instance.SERVER_EVENTS.ACTOR).forEach(
    (actorEvent) => {
      socket.on(
        ServerSocketRequestEvents.Instance.SERVER_EVENTS.ACTOR + actorEvent,
        async (actorId, iosSocketId) => {
          await handleActorEvent(actorEvent, socket, actorId, iosSocketId);
        }
      );
    }
  );
}

export async function handleActorEvent(event, socket, actorId, iosSocketId) {
  let actor = getValidActor(socket, actorId, iosSocketId);
  if (actor) {
    switch (_.startCase(_.camelCase(event))) {
      case CORE_EVENTS.ATTRIBUTES:
        createAndEmitActorAttributes(socket, actor, iosSocketId);
        break;
      case CORE_EVENTS.ABILITIES:
        createAndEmitActorAbilities(socket, actor, iosSocketId);
        break;
      case CORE_EVENTS.BASE_DATA:
        await createAndEmitActorBaseData(socket, actor, iosSocketId);
        break;
      case CORE_EVENTS.CURRENCY:
        createAndEmitActorCurrency(socket, actor, iosSocketId);
        break;
      case CORE_EVENTS.DETAILS:
        createAndEmitActorDetails(socket, actor, iosSocketId);
        break;
      case CORE_EVENTS.INVENTORY:
        await createAndEmitActorInventory(socket, actor, iosSocketId);
        break;
      case CORE_EVENTS.SKILLS:
        createAndEmitActorSkills(socket, actor, iosSocketId);
        break;
      case CORE_EVENTS.SPELLS:
        await createAndEmitActorSpells(socket, actor, iosSocketId);
        break;
      case CORE_EVENTS.SPELL_SLOTS:
        createAndEmitActorSpellSlots(socket, actor, iosSocketId);
        break;
      case CORE_EVENTS.TRAITS:
        createAndEmitActorTraits(socket, actor, iosSocketId);
        break;
    }
  }

  function createAndEmitActorAbilities(socket, actor, iosSocketId) {
    socket.emit(
      ServerSocketRequestEvents.Instance.FOUNDRY_EVENTS.ACTOR.ABILITIES,
      {
        abilities: Object.entries(actor.data.data.abilities).map(
          (abilityEntry) => {
            let abilityId = abilityEntry[0];
            let ability = abilityEntry[1];
            return {
              id: abilityEntry[0],
              name: CONFIG.DND5E.abilities[abilityId],
              bonusModifier: ability.mod,
              totalScore: ability.value,
              bonusSaveModifier: ability.save,
            };
          }
        ),
      },
      iosSocketId
    );
  }
}

function createAndEmitActorAttributes(socket, actor, iosSocketId) {
  let attributes = actor.data.data.attributes;
  socket.emit(
    ServerSocketRequestEvents.Instance.FOUNDRY_EVENTS.ACTOR.ATTRIBUTES,
    {
      deathSaves: {
        success: attributes.death.success,
        failure: attributes.death.failure,
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

async function createAndEmitActorBaseData(socket, actor, iosSocketId) {
  socket.emit(
    ServerSocketRequestEvents.Instance.FOUNDRY_EVENTS.ACTOR.BASE_DATA,
    {
      id: actor.data._id,
      name: actor.data.name,
      image: await getBase64ImageData(actor.data.img).then((imageData) => {
        return removeBase64Metadata(imageData);
      }),
    },
    iosSocketId
  );
}

function createAndEmitActorCurrency(socket, actor, iosSocketId) {
  socket.emit(
    ServerSocketRequestEvents.Instance.FOUNDRY_EVENTS.ACTOR.CURRENCY,
    {
      copper: actor.data.data.currency.cp,
      silver: actor.data.data.currency.sp,
      electrum: actor.data.data.currency.cp,
      gold: actor.data.data.currency.gp,
      platinum: actor.data.data.currency.pp,
    },
    iosSocketId
  );
}

function createAndEmitActorDetails(socket, actor, iosSocketId) {
  socket.emit(
    ServerSocketRequestEvents.Instance.FOUNDRY_EVENTS.ACTOR.DETAILS,
    {
      biography: removeHtml(actor.data.data.details.biography.value),
      appearance: removeHtml(actor.data.data.details.appearance),
      flaws: removeHtml(actor.data.data.details.flaw),
      bonds: removeHtml(actor.data.data.details.bond),
      personalityTraits: removeHtml(actor.data.data.details.trait),
      ideals: removeHtml(actor.data.data.details.ideal),
    },
    iosSocketId
  );
}

async function createAndEmitActorInventory(socket, actor, iosSocketId) {
  const inventory = {
    weapon: [],
    equipment: [],
    consumable: [],
    tool: [],
    backpack: [],
    loot: [],
  };

  await Promise.all(
    actor.items
      .filter((item) => Object.keys(inventory).includes(item.data.type))
      .map(async (item) => {
        return {
          id: item.data._id,
          name: item.data.name,
          description: removeHtml(item.data.data.description.value),
          type: item.data.type,
          hasAttack: item.hasAttack,
          hasDamage: item.hasDamage,
          quantity: Number(item.data.data.quantity) || 0,
          weight: Number(item.data.data.weight) || 0,
          cost: Number(item.data.data.price) || 0,
          image: await getBase64ImageData(item.data.img).then((imageData) => {
            return removeBase64Metadata(imageData);
          }),
          numUsagesRemaining: item.data.data.uses
            ? Number(item.data.data.uses.value)
            : 0,
          maxUsages: item.data.data.uses ? Number(item.data.data.uses.max) : 0,
        };
      })
  ).then((items) => {
    items.forEach((item) => {
      inventory[item.type].push(item);
    });
    socket.emit(
      ServerSocketRequestEvents.Instance.FOUNDRY_EVENTS.ACTOR.INVENTORY,
      {
        currentCapacity: actor.data.data.attributes.encumbrance.value,
        carryingCapacity: actor.data.data.attributes.encumbrance.max,
        weapons: inventory.weapon,
        equipment: inventory.equipment,
        consumables: inventory.consumable,
        tools: inventory.tool,
        containers: inventory.backpack,
        loot: inventory.loot,
      },
      iosSocketId
    );
  });
}

function createAndEmitActorSkills(socket, actor, iosSocketId) {
  socket.emit(
    ServerSocketRequestEvents.Instance.FOUNDRY_EVENTS.ACTOR.SKILLS,
    {
      skills: Object.entries(actor.data.data.skills).map((skillEntry) => {
        let skillId = skillEntry[0];
        let skill = skillEntry[1];
        return {
          id: skillId,
          name: skill.label,
          proficient: skill.prof > 0,
          abilityModifier: skill.ability,
          bonusModifier: skill.total,
          passiveValue: skill.passive,
        };
      }),
    },
    iosSocketId
  );
}

async function createAndEmitActorSpells(socket, actor, iosSocketId) {
  socket.emit(
    ServerSocketRequestEvents.Instance.FOUNDRY_EVENTS.ACTOR.SPELLS,
    {
      spells: await Promise.all(
        actor.items
          .filter((item) => item.type === "spell")
          .map(async (spell) => {
            return {
              id: spell.data._id,
              name: spell.data.name,
              description: removeHtml(spell.data.data.description.value),
              spellLevel: spell.data.data.level,
              hasAttack: spell.hasAttack,
              hasDamage: spell.hasDamage,
              isHealing: spell.isHealing !== false,
              prepared:
                spell.data.data.level > 0 &&
                spell.data.data.preparation.mode === "prepared" &&
                spell.data.data.preparation.prepared,
              image: await getBase64ImageData(spell.data.img).then(
                (imageData) => {
                  return removeBase64Metadata(imageData);
                }
              ),
            };
          })
      ),
    },
    iosSocketId
  );
}

function createAndEmitActorSpellSlots(socket, actor, iosSocketId) {
  socket.emit(
    ServerSocketRequestEvents.Instance.FOUNDRY_EVENTS.ACTOR.SPELL_SLOTS,
    {
      spellSlots: Object.entries(actor.data.data.spells).map(
        (spellSlotEntry) => {
          let spellId = spellSlotEntry[0];
          let spellSlot = spellSlotEntry[1];
          let spellLevel =
            spellId === "pact"
              ? spellSlot.level
              : Number(spellId.split("spell")[1]);
          return {
            id: spellId,
            spellLevel: spellLevel,
            spellLevelLabel: CONFIG.DND5E.spellLevels[spellLevel],
            maxSpellSlots: spellSlot.max,
            currentSpellSlots: spellSlot.value,
            isPact: spellId === "pact",
          };
        }
      ),
    },
    iosSocketId
  );
}

function createAndEmitActorTraits(socket, actorId, iosSocketId) {
  let traits = actor.data.data.traits;
  socket.emit(
    ServerSocketRequestEvents.Instance.FOUNDRY_EVENTS.ACTOR.TRAITS,
    {
      languages: traits.languages.value,
      size: CONFIG.DND5E.actorSizes[traits.size],
      toolProficiencies: traits.toolProf.value,
      weaponProficiencies: traits.weaponProf.value?.map(
        (weaponProficiency) =>
          CONFIG.DND5E.weaponProficiencies[weaponProficiency]
      ),
      armorProficiencies: traits.armorProf.value?.map(
        (armorProficiency) => CONFIG.DND5E.armorProficiencies[armorProficiency]
      ),
      damageImmunities: traits.di.value || [],
      damageResistances: traits.dr.value || [],
      damageVulnerabilities: traits.dv.value || [],
      conditionImmunities: traits.ci.value || [],
      senses: {
        blindsight: traits.senses.blindsight || 0,
        darkvision: traits.senses.darkvision || 0,
        special: traits.senses.special || "",
        tremorsense: traits.senses.tremorsense || 0,
        truesight: traits.senses.truesight || 0,
        units: traits.senses.units || "ft",
      },
    },
    iosSocketId
  );
}
