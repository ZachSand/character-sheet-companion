//
//  ExpandedItemRowViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import Foundation

class ExpandedItemRowViewModel: ObservableObject {
    private var itemDisplayListener = SocketManagerWrapper.sharedInstance.displayListenerWrapper.displayItemListener

    func displayItem(inventoryItem: ActorInventoryItemModel) {
        itemDisplayListener.displayItemCard(itemId: inventoryItem.id)
    }
}
