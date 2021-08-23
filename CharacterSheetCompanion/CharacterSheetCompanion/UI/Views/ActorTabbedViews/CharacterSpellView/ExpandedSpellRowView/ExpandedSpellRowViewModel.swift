//
//  ExpandedSpellRowViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class ExpandedSpellRowViewModel: ObservableObject {
    private var itemDisplayListener: DisplayItemListener?

    init() {
        do {
            try itemDisplayListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func displayItem(spell: ActorSpellModel) {
        if let listener = itemDisplayListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let displayItem = ItemDisplayModel(actorId: actor.id, itemId: spell.id)
            listener.displayItemCard(displayItem: displayItem)
        }
    }
}
