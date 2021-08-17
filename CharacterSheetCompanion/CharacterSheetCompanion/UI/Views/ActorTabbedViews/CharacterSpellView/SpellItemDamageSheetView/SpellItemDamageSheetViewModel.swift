//
//  SpellItemDamageSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class SpellItemDamageSheetViewModel: ObservableObject {
    var itemDamageListener: RollItemDamageListener?

    init() {
        do {
            try itemDamageListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
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
}
