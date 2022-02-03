//
//  ItemDamageSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class ItemToolSheetViewModel: ObservableObject {
    private var itemToolListener = SocketManagerWrapper.sharedInstance.rollListenerWrapper.itemToolRollListener

    func rollItemToolRoll(inventoryItem: ActorInventoryItemModel, advantage: Bool, disadvantage: Bool) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            itemToolListener.request(model: ItemToolRollModel(actorId: actor.id, itemId: inventoryItem.id, advantage: advantage, disadvantage: disadvantage, result: 0))
        }
    }
}
