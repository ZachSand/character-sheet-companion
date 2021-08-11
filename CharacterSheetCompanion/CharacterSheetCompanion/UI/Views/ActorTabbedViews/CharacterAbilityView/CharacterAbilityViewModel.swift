//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation
import SwiftUI

class CharacterAbilityViewModel: ObservableObject {
    @Published var abilities: [ActorAbilityModel]
    @Published var showRollResult: Bool

    var abilityListener: AbilityListener?
    var rollResultStack = Stack<AbilityRollModel>()

    init(abilities: [ActorAbilityModel]) {
        self.abilities = abilities
        showRollResult = false
        do {
            try abilityListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func rollAbility(ability: ActorAbilityModel, isSave: Bool, advantage: Bool, disadvantage: Bool) {
        if let listener = abilityListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let roll = AbilityRollModel(actorId: actor.id, ability: ability.id, advantage: advantage, disadvantage: disadvantage, isSave: isSave, result: 0)
            DispatchQueue.main.async {
                listener.rollAbility(abilityRoll: roll) { abilityRollModel in
                    if let rollResult = abilityRollModel {
                        self.rollResultStack.push(rollResult)
                        self.showRollResult = true
                    }
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
