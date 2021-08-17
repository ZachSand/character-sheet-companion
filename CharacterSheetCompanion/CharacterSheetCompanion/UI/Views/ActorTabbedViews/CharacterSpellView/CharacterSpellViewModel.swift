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

    var subscription = Set<AnyCancellable>()

    var spellSlotListener: ActorSpellSlotListener?

    init() {
        do {
            try spellSlotListener = FoundrySocketIOManager.sharedInstance.getListener()
            spellSlotListener?.spellSlotPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.spellSlots = model
                    self.spellSlots?.sort(by: { spellSlotOne, spellSlotTwo in
                        spellSlotOne.spellLevel < spellSlotTwo.spellLevel
                    })
                })
                .store(in: &subscription)
        } catch {}
    }
}
