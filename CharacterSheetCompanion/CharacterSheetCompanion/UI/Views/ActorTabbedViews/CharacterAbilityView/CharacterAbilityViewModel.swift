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

    var subscription = Set<AnyCancellable>()
    var rollAbilityListener: RollAbilityListener?
    var actorAbilityListener: ActorAbilityListener?
    var rollResultStack = Stack<AbilityRollModel>()

    init() {
        showRollResult = false
        do {
            try rollAbilityListener = FoundrySocketIOManager.sharedInstance.getListener()
            try actorAbilityListener = FoundrySocketIOManager.sharedInstance.getListener()

            actorAbilityListener?.abilitiesPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.abilities = model
                })
                .store(in: &subscription)
        } catch {
            preconditionFailure("Unable to get ability listeners: ")
        }
    }

    func rollAbility(ability: ActorAbilityModel, isSave: Bool, advantage: Bool, disadvantage: Bool) {
        if let listener = rollAbilityListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let roll = AbilityRollModel(actorId: actor.id, ability: ability.id, advantage: advantage, disadvantage: disadvantage, isSave: isSave, result: 0)
            DispatchQueue.main.async {
                listener.rollAbility(abilityRoll: roll) { abilityRollModel in
                    self.rollResultStack.push(abilityRollModel)
                    self.showRollResult = true
                }
            }
        }
    }

    func getRollResult() -> AbilityRollModel {
        if rollResultStack.items.isEmpty {
            return AbilityRollModel(actorId: "", ability: "Unknown", advantage: false, disadvantage: false, isSave: false, result: 0)
        }
        return rollResultStack.pop()
    }
}

class ActorAbilitySubscriber: Subscriber {
    typealias Input = [ActorAbilityModel]?
    typealias Failure = Never

    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    func receive(_: [ActorAbilityModel]?) -> Subscribers.Demand {
        .none
    }

    func receive(completion: Subscribers.Completion<Never>) {
        print("Completion event:", completion)
    }
}
