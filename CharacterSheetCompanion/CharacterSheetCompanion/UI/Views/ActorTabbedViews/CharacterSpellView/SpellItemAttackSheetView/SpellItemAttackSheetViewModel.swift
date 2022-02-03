//
//  SpellItemAttackSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class SpellItemAttackSheetViewModel: ObservableObject {
    private var itemAttackListener = SocketManagerWrapper.sharedInstance.rollListenerWrapper.itemAttackRollListener

    func rollItemAttack(spell: ActorSpellModel, advantage: Bool, disadvantage: Bool, consumeSpellSlot _: Bool) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            itemAttackListener.request(model: ItemAttackRollModel(actorId: actor.id, itemId: spell.id, advantage: advantage, disadvantage: disadvantage, result: 0))
        }
    }
}
