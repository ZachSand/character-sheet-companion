//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation

class CharacterSpellViewModel: ObservableObject {
    @Published var spellSlots: [SpellSlotModel]

    var itemAttackListener: ItemAttackListener?
    var itemDamageListener: ItemDamageListener?
    var itemDisplayListener: ItemDisplayListener?
    var spellDialogListener: SpellDialogListener?

    init(spellSlots: [SpellSlotModel]) {
        self.spellSlots = spellSlots
        do {
            try itemAttackListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemDamageListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemDisplayListener = FoundrySocketIOManager.sharedInstance.getListener()
            try spellDialogListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func rollItemAttack(spell: SpellModel, advantage: Bool, disadvantage: Bool, consumeSpellSlot _: Bool) {
        if let listener = itemAttackListener {
            let itemAttackRoll = ItemAttackRollModel(actorId: "", itemId: spell.id, advantage: advantage, disadvantage: disadvantage, result: 0)
            DispatchQueue.main.async {
                listener.rollItemAttack(attackRoll: itemAttackRoll) { attackRollResult in
                    if let itemAttackRollResult = attackRollResult {
                        print(itemAttackRollResult)
                    }
                }
            }
        }
    }

    func rollItemDamage(spell: SpellModel, critical: Bool, versatile: Bool) {
        if let listener = itemDamageListener {
            let itemDamageRoll = ItemDamageRollModel(actorId: "", itemId: spell.id, critical: critical, versatile: versatile, result: 0)
            DispatchQueue.main.async {
                listener.rollItemDamage(damageRoll: itemDamageRoll) { damageRollResult in
                    if let itemDamageRollResult = damageRollResult {
                        print(itemDamageRollResult)
                    }
                }
            }
        }
    }

    func displayItem(spell: SpellModel) {
        if let listener = itemDisplayListener {
            let displayItem = ItemDisplayModel(actorId: "", itemId: spell.id)
            listener.displayItemCard(displayItem: displayItem)
        }
    }
}
