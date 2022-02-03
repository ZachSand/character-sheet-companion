//
//  SpellItemDamageSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class SpellItemDamageSheetViewModel: ObservableObject {
    private var itemDamageListener = SocketManagerWrapper.sharedInstance.rollListenerWrapper.itemDamageRollListener

    func rollItemDamage(spell: ActorSpellModel, critical: Bool, versatile: Bool) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            itemDamageListener.request(model: ItemDamageRollModel(actorId: actor.id, itemId: spell.id, critical: critical, versatile: versatile, result: 0))
        }
    }
}
