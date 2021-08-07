//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation

class CharacterSpellViewModel: ObservableObject {
    @Published var foundryActor: ActorDataModel
    var itemAttackListener: ItemAttackListener?
    var itemDamageListener: ItemDamageListener?
    var itemDisplayListener: ItemDisplayListener?
    var spellDialogListener: SpellDialogListener?

    var spellLevelMapping: [Int: String] = [
        0: "Cantrip",
        1: "1st Level",
        2: "2nd Level",
        3: "3rd Level",
        4: "4th Level",
        5: "5th Level",
        6: "6th Level",
        7: "7th Level",
        8: "8th Level",
        9: "9th Level",
    ]

    var spellDialogMapping: [String: [SpellDialogModel]]

    init(foundryActor: ActorDataModel) {
        self.foundryActor = foundryActor
        spellDialogMapping = [:]

        do {
            try itemAttackListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemDamageListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemDisplayListener = FoundrySocketIOManager.sharedInstance.getListener()
            try spellDialogListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func rollItemAttack(spellSummary: SpellSummary, advantage: Bool, disadvantage: Bool, consumeSpellSlot _: Bool) {
        if let listener = itemAttackListener {
            let itemAttackRoll = ItemAttackRollModel(actorId: foundryActor.actor.id, itemId: spellSummary.id, advantage: advantage, disadvantage: disadvantage, result: 0)
            DispatchQueue.main.async {
                listener.rollItemAttack(attackRoll: itemAttackRoll) { attackRollResult in
                    if let itemAttackRollResult = attackRollResult {
                        print(itemAttackRollResult)
                    }
                }
            }
        }
    }

    func rollItemDamage(spellSummary: SpellSummary, critical: Bool, versatile: Bool) {
        if let listener = itemDamageListener {
            let itemDamageRoll = ItemDamageRollModel(actorId: foundryActor.actor.id, itemId: spellSummary.id, critical: critical, versatile: versatile, result: 0)
            DispatchQueue.main.async {
                listener.rollItemDamage(damageRoll: itemDamageRoll) { damageRollResult in
                    if let itemDamageRollResult = damageRollResult {
                        print(itemDamageRollResult)
                    }
                }
            }
        }
    }

    func getSpellDialog(spellId: String) {
        if let listener = spellDialogListener {
            DispatchQueue.main.async {
                listener.getSpellDialog(actorId: self.foundryActor.actor.id, spellId: spellId) { spellDialogs in
                    if let dialogs = spellDialogs {
                        self.spellDialogMapping[spellId] = dialogs
                    }
                }
            }
        }
    }

    func getSpellCategories() -> [SpellCategory] {
        var spells: [SpellCategory] = []
        spellLevelMapping.sorted(by: { $0.0 < $1.0 }).forEach { (key: Int, value: String) in
            let spellsForLevel = getSpellForLevel(spellLevel: key)
            if !spellsForLevel.isEmpty {
                if key > 0 {
                    spells.append(SpellCategory(
                        id: value,
                        items: spellsForLevel,
                        spellSlotRemaining: foundryActor.actor.actorData.spells.spell1.value,
                        maxSpellSlot: foundryActor.actor.actorData.spells.spell1.max
                    ))
                } else {
                    spells.append(SpellCategory(id: value, items: spellsForLevel))
                }
            }
        }
        return spells
    }

    func getSpellForLevel(spellLevel: Int) -> [SpellSummary] {
        var spellSummaries: [SpellSummary] = []
        for spell in foundryActor.actor.actorItems.spells {
            if let sLevel = spell.data.level {
                if sLevel == spellLevel {
                    var hasDamage = false
                    if let damage = spell.data.damage {
                        hasDamage = damage.parts.count > 0
                    }
                    spellSummaries.append(SpellSummary(
                        id: spell.id,
                        img: spell.img,
                        name: spell.name,
                        description: spell.data.dataDescription.value,
                        level: sLevel,
                        hasDamage: hasDamage,
                        actionType: spell.data.actionType,
                        quantity: spell.data.uses?.value
                    ))
                }
            }
        }
        return spellSummaries
    }

    func hasAttack(spellSummary: SpellSummary) -> Bool {
        if let actionType = spellSummary.actionType {
            return actionType == "mwak" || actionType == "rwak" || actionType == "msak" || actionType == "rsak"
        }
        return false
    }

    func displayItem(spellSummary: SpellSummary) {
        if let listener = itemDisplayListener {
            let displayItem = ItemDisplayModel(actorId: foundryActor.actor.id, itemId: spellSummary.id)
            listener.displayItemCard(displayItem: displayItem)
        }
    }

    func getSpellDialog() {}
}

struct SpellCategory: Identifiable {
    var id: String
    var items: [SpellSummary]

    var spellSlotRemaining: Int?
    var maxSpellSlot: Int?
}

struct SpellSummary: Identifiable, Hashable {
    var id: String
    var img: String
    var name: String
    var description: String
    var level: Int
    var hasDamage: Bool

    var actionType: String?
    var quantity: Int?

    static func == (lhs: SpellSummary, rhs: SpellSummary) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
