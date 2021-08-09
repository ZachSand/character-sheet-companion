//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation
import SwiftUI

class CharacterAbilityViewModel: ObservableObject {
    @Published var abilities: [AbilityModel]
    @Published var showRollResult: Bool

    var abilityListener: AbilityListener?
    var rollResultStack = Stack<AbilityRollModel>()

    init(abilities: [AbilityModel]) {
        self.abilities = abilities
        showRollResult = false
        do {
            try abilityListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func rollAbility(ability: AbilityModel, isSave: Bool, advantage: Bool, disadvantage: Bool) {
        if let listener = abilityListener {
            let roll = AbilityRollModel(actorId: "", ability: ability.id, advantage: advantage, disadvantage: disadvantage, isSave: isSave, result: 0)
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

//    func getSenses() -> [String] {
//        var sensesText: [String] = []
//        if let senses = foundryActor.actor.actorData.traits.senses {
//            if senses.blindsight > 0 {
//                sensesText.append("Blindsight: \(senses.blindsight)\(senses.units)")
//            }
//            if senses.darkvision > 0 {
//                sensesText.append("Darkvision: \(senses.darkvision)\(senses.units)")
//            }
//            if senses.tremorsense > 0 {
//                sensesText.append("Tremorsense: \(senses.tremorsense)\(senses.units)")
//            }
//            if senses.truesight > 0 {
//                sensesText.append("Truesight: \(senses.truesight)\(senses.units)")
//            }
//        }
//        return sensesText
//    }
//
//    func getLanguages() -> [String] {
//        foundryActor.actor.actorData.traits.languages.value.map { language in
//            language.capitalizingFirstLetter()
//        }
//    }

//    private func getSavingMod(ability: Ability) -> String {
//        var savingMod = ability.mod
//        if ability.prof > 0 {
//            savingMod += foundryActor.actor.actorData.prof
//        }
//        return getMod(mod: savingMod)
//    }
}
