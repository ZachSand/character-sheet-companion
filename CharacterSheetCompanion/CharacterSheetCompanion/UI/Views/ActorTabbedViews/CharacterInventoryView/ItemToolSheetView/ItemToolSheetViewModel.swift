//
//  ItemDamageSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class ItemToolSheetViewModel: ObservableObject {
    var itemToolListener: RollToolListener?

    init() {
        do {
            try itemToolListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func rollItemToolRoll(inventoryItem: ActorInventoryItemModel, advantage: Bool, disadvantage: Bool) {
        if let listener = itemToolListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let itemToolRoll = ItemToolRollModel(actorId: actor.id, itemId: inventoryItem.id, advantage: advantage, disadvantage: disadvantage, result: 0)
            DispatchQueue.main.async {
                listener.rollItemTool(itemToolRoll: itemToolRoll) { toolRollResult in
                    print(toolRollResult)
                }
            }
        }
    }
}
