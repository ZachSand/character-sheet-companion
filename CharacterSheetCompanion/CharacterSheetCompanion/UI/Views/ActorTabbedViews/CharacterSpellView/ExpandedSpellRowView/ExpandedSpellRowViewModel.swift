//
//  ExpandedSpellRowViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class ExpandedSpellRowViewModel: ObservableObject {
    private var itemDisplayListener = SocketManagerWrapper.sharedInstance.displayListenerWrapper.displayItemListener

    func displayItem(spell: ActorSpellModel) {
        itemDisplayListener.displayItemCard(itemId: spell.id)
    }
}
