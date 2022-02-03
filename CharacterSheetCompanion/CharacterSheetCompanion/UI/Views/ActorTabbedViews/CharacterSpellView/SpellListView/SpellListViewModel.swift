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
    private var spellListener = SocketManagerWrapper.sharedInstance.actorListenerWrapper.actorSpellListener
    private var itemDisplayListener = SocketManagerWrapper.sharedInstance.displayListenerWrapper.displayItemListener

    init(spellLevel: Int) {
        self.spellLevel = spellLevel
        spellListener.modelPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { model in
                self.spells = model?.spells
            })
            .store(in: &subscription)
    }

    func displayItem(spell: ActorSpellModel) {
        itemDisplayListener.displayItemCard(itemId: spell.id)
    }
}
