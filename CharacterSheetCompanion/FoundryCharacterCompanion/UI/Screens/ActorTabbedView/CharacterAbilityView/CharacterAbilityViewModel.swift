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
        "wis": "Wisdome",
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
            abilityMap.append(ActorAbility(id: key, ability: value))
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
}

struct ActorAbility: Identifiable {
    var id: String
    var ability: Ability
}
