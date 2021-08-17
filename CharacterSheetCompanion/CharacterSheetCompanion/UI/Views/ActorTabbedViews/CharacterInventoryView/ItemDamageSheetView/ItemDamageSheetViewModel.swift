//
//  ItemDamageSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class ItemDamageSheetViewModel: ObservableObject {
    var itemDamageListener: RollItemDamageListener?

    init() {
        do {
            try itemDamageListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func rollItemDamage(inventoryItem: ActorInventoryItemModel, critical: Bool, versatile: Bool) {
        if let listener = itemDamageListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let itemDamageRoll = ItemDamageRollModel(actorId: actor.id, itemId: inventoryItem.id, critical: critical, versatile: versatile, result: 0)
            DispatchQueue.main.async {
                listener.rollItemDamage(damageRoll: itemDamageRoll) { damageRollResult in
                    print(damageRollResult)
                }
            }
        }
    }
}
