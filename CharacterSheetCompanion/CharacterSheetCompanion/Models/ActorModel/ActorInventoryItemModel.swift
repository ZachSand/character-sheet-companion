//
//  InventoryItemModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import Foundation

struct ActorInventoryItemModel: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var description: String
    var type: String
    var hasAttack: Bool
    var hasDamage: Bool
    var quantity: Int
    var weight: Double
    var cost: Double
    var numUsagesRemaining: Int
    var maxUsages: Int

    var image: Data?

    func isConsumable() -> Bool {
        type == "consumable"
    }

    func isTool() -> Bool {
        type == "tool"
    }
}

#if DEBUG
    extension ActorInventoryItemModel {
        static let mockedDataWeapons = [
            ActorInventoryItemModel(
                id: "1",
                name: "Longsword",
                description: "Proficiency with a longsword allows you to add your proficiency bonus to the attack roll for any attack you make with it.",
                type: "weapon",
                hasAttack: true,
                hasDamage: true,
                quantity: 2,
                weight: 3,
                cost: 15,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
            ActorInventoryItemModel(
                id: "2",
                name: "Longbow",
                description: "Proficiency with a longbow allows you to add your proficiency bonus to the attack roll for any attack you make with it.",
                type: "weapon",
                hasAttack: true,
                hasDamage: true,
                quantity: 1,
                weight: 2,
                cost: 50,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
            ActorInventoryItemModel(
                id: "3",
                name: "Dagger",
                description: "Proficiency with a dagger allows you to add your proficiency bonus to the attack roll for any attack you make with it.",
                type: "weapon",
                hasAttack: true,
                hasDamage: true,
                quantity: 1,
                weight: 2,
                cost: 2,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
        ]

        static let mockedDataEquipment = [
            ActorInventoryItemModel(
                id: "1",
                name: "Chain Mail",
                description: "Made of interlocking metal rings, chain mail includes a layer of quilted fabric worn underneath the mail to prevent chafing and to cushion the impact of blows. The suit includes gauntlets.",
                type: "equipment",
                hasAttack: false,
                hasDamage: false,
                quantity: 1,
                weight: 55,
                cost: 75,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
            ActorInventoryItemModel(
                id: "2",
                name: "Studded Leather",
                description: "Made of interlocking metal rings, chain mail includes a layer of quilted fabric worn underneath the mail to prevent chafing and to cushion the impact of blows. The suit includes gauntlets.",
                type: "equipment",
                hasAttack: false,
                hasDamage: false,
                quantity: 1,
                weight: 55,
                cost: 45,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
            ActorInventoryItemModel(
                id: "3",
                name: "Ring of Evasion",
                description: "This ring has 3 charges, and it regains 1d3 expended charges daily at dawn. When you fail a Dexterity saving throw while wearing it, you can use your reaction to expend 1 of its charges to succeed on that saving throw instead.",
                type: "equipment",
                hasAttack: false,
                hasDamage: false,
                quantity: 1,
                weight: 0,
                cost: 12500,
                numUsagesRemaining: 1,
                maxUsages: 3
            ),
        ]

        static let mockedDataConsumables = [
            ActorInventoryItemModel(
                id: "1",
                name: "Potion of Healing",
                description: "You regain hit points when you drink this potion. The number of hit points depends on the potion’s rarity, as shown in the Potions of Healing table. Whatever its potency, the potion’s red liquid glimmers when agitated.",
                type: "consumable",
                hasAttack: false,
                hasDamage: false,
                quantity: 1,
                weight: 0,
                cost: 50,
                numUsagesRemaining: 1,
                maxUsages: 3
            ),
            ActorInventoryItemModel(
                id: "1",
                name: "Rations (1 day)",
                description: "Rations consist of dry foods suitable for extended travel, including jerky, dried fruit, hardtack, and nuts.",
                type: "consumable",
                hasAttack: false,
                hasDamage: false,
                quantity: 5,
                weight: 2,
                cost: 0.5,
                numUsagesRemaining: 1,
                maxUsages: 1
            ),
            ActorInventoryItemModel(
                id: "3",
                name: "Scroll of Protectino",
                description: "Using an action to read the scroll encloses you in a invisible barrier that extends from you to form a 5-foot-radius, 10-foot-high cylinder. For 5 minutes, this barrier prevents creatures of the specified type from entering or affecting anything within the cylinder. The cylinder moves with you and remains centered on you. However, if you move in such a way that a creature of the specified type would be inside the cylinder, the effect ends. A creature can attempt to overcome the barrier by using an action to make a DC 15 Charisma check. On a success, the creature ceases to be affected by the barrier.",
                type: "consumable",
                hasAttack: false,
                hasDamage: false,
                quantity: 5,
                weight: 2,
                cost: 500,
                numUsagesRemaining: 1,
                maxUsages: 1
            ),
        ]

        static let mockedDataTools = [
            ActorInventoryItemModel(
                id: "1",
                name: "Alchemist's Supplies",
                description: "These special tools include the items needed to pursue a craft or trade. Proficiency with a set of artisan's tools lets you add your proficiency bonus to any ability checks you make using the tools in your craft. Each type of artisan's tools requires a separate proficiency.",
                type: "tool",
                hasAttack: false,
                hasDamage: false,
                quantity: 1,
                weight: 8,
                cost: 50,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
            ActorInventoryItemModel(
                id: "2",
                name: "Bagpipes",
                description: "If you have proficiency with a given musical instrument, you can add your proficiency bonus to any ability checks you make to play music with the instrument. A bard can use bagpipes as a spellcasting focus.",
                type: "tool",
                hasAttack: false,
                hasDamage: false,
                quantity: 1,
                weight: 6,
                cost: 30,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
            ActorInventoryItemModel(
                id: "3",
                name: "Dice Set",
                description: "If you are proficient with a gaming set, you can add your proficiency bonus to ability checks you make to play a game with that set.",
                type: "tool",
                hasAttack: false,
                hasDamage: false,
                quantity: 1,
                weight: 6,
                cost: 0.1,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
        ]

        static let mockedDataContainers = [
            ActorInventoryItemModel(
                id: "1",
                name: "Backpack",
                description: "A backpack is a leather pack carried on the back, typically with straps to secure it. A backpack can hold 1 cubic foot/ 30 pounds of gear.",
                type: "container",
                hasAttack: false,
                hasDamage: false,
                quantity: 1,
                weight: 5,
                cost: 2,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
            ActorInventoryItemModel(
                id: "2",
                name: "Quiver",
                description: "A quiver can hold up to 20 arrows.",
                type: "container",
                hasAttack: false,
                hasDamage: false,
                quantity: 1,
                weight: 1,
                cost: 1,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
            ActorInventoryItemModel(
                id: "3",
                name: "Case, Map or Scroll",
                description: "This cylindrical leather case can hold up to ten rolled-up sheets of paper or five rolled-up sheets of parchment.",
                type: "container",
                hasAttack: false,
                hasDamage: false,
                quantity: 1,
                weight: 1,
                cost: 1,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
        ]

        static let mockedDataLoot = [
            ActorInventoryItemModel(
                id: "1",
                name: "Spellbook",
                description: "Essential for wizards, a spellbook is a leather-bound tome with 100 blank vellum pages suitable for recording spells.",
                type: "loot",
                hasAttack: false,
                hasDamage: false,
                quantity: 1,
                weight: 3,
                cost: 50,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
            ActorInventoryItemModel(
                id: "2",
                name: "Ball Bearings (bag of 1,000)",
                description: "As an action, you can spill these tiny metal balls from their pouch to cover a level, square area that is 10 feet on a side. A creature moving across the covered area must succeed on a DC 10 Dexterity saving throw or fall prone. A creature moving through the area at half speed doesn't need to make the save.",
                type: "loot",
                hasAttack: false,
                hasDamage: false,
                quantity: 1,
                weight: 2,
                cost: 1,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
            ActorInventoryItemModel(
                id: "2",
                name: "Caltrops (bag of 20)",
                description: "As an action, you can spread a bag of caltrops to cover a square area that is 5 feet on a side. Any creature that enters the area must succeed on a DC 15 Dexterity saving throw or stop moving this turn and take 1 piercing damage. Taking this damage reduces the creature's walking speed by 10 feet until the creature regains at least 1 hit point. A creature moving through the area at half speed doesn't need to make the save.",
                type: "loot",
                hasAttack: false,
                hasDamage: false,
                quantity: 2,
                weight: 2,
                cost: 1,
                numUsagesRemaining: 0,
                maxUsages: 0
            ),
        ]
    }
#endif
