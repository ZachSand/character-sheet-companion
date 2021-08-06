//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation
import SwiftUI

class CharacterAbilityViewModel: ObservableObject {
    @Published var foundryActor: ActorModel
    @Published var showRollResult: Bool

    var abilityListener: AbilityListener?

    let abilityNameMapping: [String: String] = [
        "str": "Strength",
        "con": "Constitution",
        "wis": "Wisdom",
        "cha": "Charisma",
        "dex": "Dexterity",
        "int": "Intelligence",
    ]

    var rollResultStack = Stack<AbilityRollModel>()

    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor
        showRollResult = false
        do {
            try abilityListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func getClassInfo() -> String {
        var classInfo = ""
        for data in foundryActor.actor.actorData.classes {
            classInfo += data.name + " " + String(data.levels)
            classInfo += "/"
        }
        classInfo.removeLast()
        return classInfo
    }

    func getAbilities() -> [ActorAbility] {
        var abilityMap: [ActorAbility] = []
        foundryActor.actor.actorData.abilities.sorted(by: { $0.0 < $1.0 }).forEach { (key: String, value: Ability) in
            if let abilityName = abilityNameMapping[key] {
                abilityMap.append(ActorAbility(id: key, name: abilityName, total: "(\(value.value))", mod: getMod(mod: value.mod), savingMod: getSavingMod(ability: value)))
            }
        }
        return abilityMap
    }

    func rollAbility(actorAbility: ActorAbility, isSave: Bool, advantage: Bool, disadvantage: Bool) {
        if let listener = abilityListener {
            let roll = AbilityRollModel(actorId: foundryActor.actor.id, ability: actorAbility.id, advantage: advantage, disadvantage: disadvantage, isSave: isSave, result: 0)
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
            return AbilityRollModel(actorId: foundryActor.actor.id, ability: "Unknown", advantage: false, disadvantage: false, isSave: false, result: 0)
        }
        return rollResultStack.pop()
    }

    func getSenses() -> [String] {
        var sensesText: [String] = []
        if let senses = foundryActor.actor.actorData.traits.senses {
            if senses.blindsight > 0 {
                sensesText.append("Blindsight: \(senses.blindsight)\(senses.units)")
            }
            if senses.darkvision > 0 {
                sensesText.append("Darkvision: \(senses.darkvision)\(senses.units)")
            }
            if senses.tremorsense > 0 {
                sensesText.append("Tremorsense: \(senses.tremorsense)\(senses.units)")
            }
            if senses.truesight > 0 {
                sensesText.append("Truesight: \(senses.truesight)\(senses.units)")
            }
        }
        return sensesText
    }

    func getLanguages() -> [String] {
        return foundryActor.actor.actorData.traits.languages.value.map { language in
            language.capitalizingFirstLetter()
        }
    }

    private func getSavingMod(ability: Ability) -> String {
        var savingMod = ability.mod
        if ability.prof > 0 {
            savingMod += foundryActor.actor.actorData.prof
        }
        return getMod(mod: savingMod)
    }

    private func getMod(mod: Int) -> String {
        if mod > 0 {
            return "+\(mod)"
        }
        return String(mod)
    }
}

struct ActorAbility: Identifiable {
    var id: String
    var name: String
    var total: String
    var mod: String
    var savingMod: String
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }
}
