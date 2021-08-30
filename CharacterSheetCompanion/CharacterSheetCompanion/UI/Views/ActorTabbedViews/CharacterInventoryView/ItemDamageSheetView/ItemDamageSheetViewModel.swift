//
//  ItemDamageSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class ItemDamageSheetViewModel: ObservableObject {
    private var itemDamageListener = SocketManagerWrapper.sharedInstance.rollListenerWrapper.itemDamageRollListener

    func rollItemDamage(inventoryItem: ActorInventoryItemModel, critical: Bool, versatile: Bool) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            itemDamageListener.request(model: ItemDamageRollModel(actorId: actor.id, itemId: inventoryItem.id, critical: critical, versatile: versatile, result: 0))
        }
    }
}
