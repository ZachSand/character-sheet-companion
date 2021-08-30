//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Combine
import Foundation

class CharacterSpellViewModel: ObservableObject {
    @Published var spellSlots: [ActorSpellSlotModel]?

    private var subscription = Set<AnyCancellable>()
    private var spellSlotListener = SocketManagerWrapper.sharedInstance.actorListenerWrapper.actorSpellSlotListener

    init() {
        spellSlotListener.modelPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { model in
                self.spellSlots = model?.spellSlots
                self.spellSlots?.sort(by: { spellSlotOne, spellSlotTwo in
                    spellSlotOne.spellLevel < spellSlotTwo.spellLevel
                })
            })
            .store(in: &subscription)
    }
}
