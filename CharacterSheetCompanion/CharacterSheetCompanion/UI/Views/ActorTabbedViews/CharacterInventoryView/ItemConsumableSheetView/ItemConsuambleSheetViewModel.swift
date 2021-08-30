//
//  ItemConsuambleSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class ItemConsumableSheetViewModel: ObservableObject {
    private var itemConsumeListener = SocketManagerWrapper.sharedInstance.rollListenerWrapper.itemConsumeRollListener

    func rollItemConsume(inventoryItem: ActorInventoryItemModel, consume: Bool) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            itemConsumeListener.request(model: ItemConsumeRollModel(actorId: actor.id, itemId: inventoryItem.id, consume: consume, result: 0))
        }
    }

    func getConsumeText(inventoryItem: ActorInventoryItemModel) -> String {
        "This item has \(inventoryItem.numUsagesRemaining) of \(inventoryItem.maxUsages) uses remaining. Consuming will remove one use."
    }
}
