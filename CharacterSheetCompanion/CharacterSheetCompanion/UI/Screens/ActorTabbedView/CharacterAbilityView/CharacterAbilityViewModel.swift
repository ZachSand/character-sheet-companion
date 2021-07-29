//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation

class CharacterAbilityViewModel: ObservableObject {
    @Published var foundryActor: ActorModel
    
    let abilityNameMapping: [String: String] = [
        "str": "Strength",
        "con": "Constitution",
        "wis": "Wisdom",
        "cha": "Charisma",
        "dex": "Dexterity",
        "int": "Intelligence",
    ]
    
    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor;
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
        foundryActor.actor.actorData.abilities.sorted( by: { $0.0 < $1.0 }).forEach { (key: String, value: Ability) in
            if let abilityName = abilityNameMapping[key] {
                abilityMap.append(ActorAbility(id: key, name: abilityName, total: "(\( value.value))", mod: getMod(mod: value.mod), savingMod: getSavingMod(ability: value)))
            }
        }
        return abilityMap
    }
    
    func rollAbility(actorAbility: ActorAbility, isSave: Bool, advantage: Bool, disadvantage: Bool) {
        let roll = AbilityRollModel(actorId: self.foundryActor.actor.id, ability: actorAbility.id, advantage: advantage, disadvantage: disadvantage, isSave: isSave, result: 0)
        DispatchQueue.main.async {
            FoundrySocketIOManager.sharedInstance.rollAbility(abilityRoll: roll) { abilityRollModel in
                if let rollResult = abilityRollModel {
                    print(rollResult.result)
                }
            }
        }
    }
    
    func getSenses() -> [String] {
        var sensesText: [String] = []
        if let senses = foundryActor.actor.actorData.traits.senses {
            if senses.blindsight > 0  {
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
    
    private func getSavingMod(ability: Ability) -> String {
        var savingMod = ability.mod
        if(ability.prof > 0) {
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
