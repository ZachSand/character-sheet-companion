//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Combine
import Foundation

class CharacterSpellViewModel: ObservableObject {
    @Published var spellSlots: [ActorSpellSlotModel]?

    var subscription = Set<AnyCancellable>()

    var itemAttackListener: RollItemAttackListener?
    var itemDamageListener: RollItemDamageListener?
    var itemDisplayListener: DisplayItemListener?
    var spellSlotListener: ActorSpellSlotListener?

    init() {
        do {
            try itemAttackListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemDamageListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemDisplayListener = FoundrySocketIOManager.sharedInstance.getListener()
            try spellSlotListener = FoundrySocketIOManager.sharedInstance.getListener()
            spellSlotListener?.spellSlotPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.spellSlots = model
                    self.spellSlots?.sort(by: { spellSlotOne, spellSlotTwo in
                        spellSlotOne.spellLevel < spellSlotTwo.spellLevel
                    })
                })
                .store(in: &subscription)
        } catch {}
    }

    func rollItemAttack(spell: ActorSpellModel, advantage: Bool, disadvantage: Bool, consumeSpellSlot _: Bool) {
        if let listener = itemAttackListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let itemAttackRoll = ItemAttackRollModel(actorId: actor.id, itemId: spell.id, advantage: advantage, disadvantage: disadvantage, result: 0)
            DispatchQueue.main.async {
                listener.rollItemAttack(attackRoll: itemAttackRoll) { attackRollResult in
                    print(attackRollResult)
                }
            }
        }
    }

    func rollItemDamage(spell: ActorSpellModel, critical: Bool, versatile: Bool) {
        if let listener = itemDamageListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let itemDamageRoll = ItemDamageRollModel(actorId: actor.id, itemId: spell.id, critical: critical, versatile: versatile, result: 0)
            DispatchQueue.main.async {
                listener.rollItemDamage(damageRoll: itemDamageRoll) { damageRollResult in
                    print(damageRollResult)
                }
            }
        }
    }

    func displayItem(spell: ActorSpellModel) {
        if let listener = itemDisplayListener {
            let displayItem = ItemDisplayModel(actorId: "", itemId: spell.id)
            listener.displayItemCard(displayItem: displayItem)
        }
    }
}
