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
    let spellLevel: Int

    private var subscription = Set<AnyCancellable>()
    private var spellListener: ActorSpellListener?
    private var itemDisplayListener: DisplayItemListener?

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
