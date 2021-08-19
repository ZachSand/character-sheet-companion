//
//  SpellItemAttackSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class SpellItemAttackSheetViewModel: ObservableObject {
    private var itemAttackListener: RollItemAttackListener?

    init() {
        do {
            try itemAttackListener = FoundrySocketIOManager.sharedInstance.getListener()
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
}
