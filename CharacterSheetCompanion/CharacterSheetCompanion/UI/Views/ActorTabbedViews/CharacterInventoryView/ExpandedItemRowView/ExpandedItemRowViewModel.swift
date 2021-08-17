//
//  ExpandedItemRowViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import Foundation

class ExpandedItemRowViewModel: ObservableObject {
    var itemDisplayListener: DisplayItemListener?

    init() {
        do {
            try itemDisplayListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func displayItem(inventoryItem: ActorInventoryItemModel) {
        if let listener = itemDisplayListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let displayItem = ItemDisplayModel(actorId: actor.id, itemId: inventoryItem.id)
            DispatchQueue.main.async {
                listener.displayItemCard(displayItem: displayItem)
            }
        }
    }
}
