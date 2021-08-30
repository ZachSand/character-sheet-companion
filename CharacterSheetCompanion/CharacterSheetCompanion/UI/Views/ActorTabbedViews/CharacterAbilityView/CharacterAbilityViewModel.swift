//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Combine
import Foundation
import SwiftUI

class CharacterAbilityViewModel: ObservableObject {
    @Published var abilities: [ActorAbilityModel]?
    @Published var showRollResult: Bool

    private var rollAbilityListener = SocketManagerWrapper.sharedInstance.rollListenerWrapper.abilityRollListener
    private var actorAbilityListener = SocketManagerWrapper.sharedInstance.actorListenerWrapper.actorAbilityListener
    private var subscription = Set<AnyCancellable>()

    private var rollResultStack = Stack<AbilityRollModel>()

    init() {
        showRollResult = false
        actorAbilityListener.modelPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { model in
                self.abilities = model?.abilities
            })
            .store(in: &subscription)
    }

    func rollAbility(ability: ActorAbilityModel, isSave: Bool, advantage: Bool, disadvantage: Bool) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            rollAbilityListener.request(model: AbilityRollModel(actorId: actor.id, ability: ability.id, advantage: advantage, disadvantage: disadvantage, isSave: isSave, result: 0))
        }
    }

    func getRollResult() -> AbilityRollModel {
        if rollResultStack.items.isEmpty {
            return AbilityRollModel(actorId: "", ability: "Unknown", advantage: false, disadvantage: false, isSave: false, result: 0)
        }
        return rollResultStack.pop()
    }
}
