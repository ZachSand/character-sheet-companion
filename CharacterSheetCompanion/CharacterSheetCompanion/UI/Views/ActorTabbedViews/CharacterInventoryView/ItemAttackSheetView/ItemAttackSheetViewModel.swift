//
//  ItemAttackSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class ItemAttackSheetViewModel: ObservableObject {
    var itemAttackListener: RollItemAttackListener?

    init() {
        do {
            try itemAttackListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func rollItemAttack(inventoryItem: ActorInventoryItemModel, advantage: Bool, disadvantage: Bool) {
        if let listener = itemAttackListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let itemAttackRoll = ItemAttackRollModel(actorId: actor.id, itemId: inventoryItem.id, advantage: advantage, disadvantage: disadvantage, result: 0)
            DispatchQueue.main.async {
                listener.rollItemAttack(attackRoll: itemAttackRoll) { attackRollResult in
                    print(attackRollResult)
                }
            }
        }
    }
}
