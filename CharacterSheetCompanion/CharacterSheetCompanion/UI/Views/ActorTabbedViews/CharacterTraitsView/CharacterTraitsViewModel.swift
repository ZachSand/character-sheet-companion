//
//  CharacterTraitsViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/19/21.
//

import Combine
import Foundation

class CharacterTraitsViewModel: ObservableObject {
    @Published var traits: ActorTraitsModel?

    private var subscription = Set<AnyCancellable>()
    private var traitsListener = SocketManagerWrapper.sharedInstance.actorListenerWrapper.actorTraistListener

    init() {
        traitsListener.modelPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { model in
                self.traits = model
            })
            .store(in: &subscription)
    }

    func getSenses() -> [String] {
        var senses: [String] = []
        if let traits = self.traits {
            senses.append("Blindsight: \(traits.senses.blindsight)\(traits.senses.units)")
            senses.append("Darkvision: \(traits.senses.darkvision)\(traits.senses.units)")
            senses.append("Tremorsense: \(traits.senses.tremorsense)\(traits.senses.units)")
            senses.append("Truesight: \(traits.senses.truesight)\(traits.senses.units)")
        }
        return senses
    }
}
