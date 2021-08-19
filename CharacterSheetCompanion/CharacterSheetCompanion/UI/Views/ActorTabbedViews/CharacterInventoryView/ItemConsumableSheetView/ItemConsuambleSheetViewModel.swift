//
//  ItemConsuambleSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class ItemConsumableSheetViewModel: ObservableObject {
    private var itemConsumeListener: RollItemConsumeListener?

    init() {
        do {
            try itemConsumeListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func rollItemConsume(inventoryItem: ActorInventoryItemModel, consume: Bool) {
        if let listener = itemConsumeListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let itemConsumeRoll = ItemConsumeRollModel(actorId: actor.id, itemId: inventoryItem.id, consume: consume, result: 0)
            DispatchQueue.main.async {
                listener.rollItemConsume(itemConsumeRoll: itemConsumeRoll) { consumeRollResult in
                    print(consumeRollResult)
                }
            }
        }
    }

    func getConsumeText(inventoryItem: ActorInventoryItemModel) -> String {
        "This item has \(inventoryItem.numUsagesRemaining) of \(inventoryItem.maxUsages) uses remaining. Consuming will remove one use."
    }
}
