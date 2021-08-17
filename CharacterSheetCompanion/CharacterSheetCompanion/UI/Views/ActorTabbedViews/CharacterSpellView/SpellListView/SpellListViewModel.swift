//
//  SpellViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/13/21.
//

import Combine
import Foundation

class SpellListViewModel: ObservableObject {
    @Published var spells: [ActorSpellModel]?
    var subscription = Set<AnyCancellable>()
    let spellLevel: Int

    var spellListener: ActorSpellListener?
    var itemDisplayListener: DisplayItemListener?

    init(spellLevel: Int) {
        self.spellLevel = spellLevel
        do {
            try itemDisplayListener = FoundrySocketIOManager.sharedInstance.getListener()
            try spellListener = FoundrySocketIOManager.sharedInstance.getListener()
            spellListener?.spellsPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.spells = model
                })
                .store(in: &subscription)
        } catch {}
    }

    func displayItem(spell: ActorSpellModel) {
        if let listener = itemDisplayListener {
            let displayItem = ItemDisplayModel(actorId: "", itemId: spell.id)
            listener.displayItemCard(displayItem: displayItem)
        }
    }
}
