//
//  ItemAttackSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class ItemAttackSheetViewModel: ObservableObject {
    private var itemAttackListener = SocketManagerWrapper.sharedInstance.rollListenerWrapper.itemAttackRollListener

    func rollItemAttack(inventoryItem: ActorInventoryItemModel, advantage: Bool, disadvantage: Bool) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            itemAttackListener.request(model: ItemAttackRollModel(actorId: actor.id, itemId: inventoryItem.id, advantage: advantage, disadvantage: disadvantage, result: 0))
        }
    }
}
