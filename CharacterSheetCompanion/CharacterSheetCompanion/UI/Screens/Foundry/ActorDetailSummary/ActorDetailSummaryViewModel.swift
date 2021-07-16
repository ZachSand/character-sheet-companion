//
//  ActorDetailSummaryViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/13/21.
//

import Foundation

class ActorDetailSummaryViewModel: ObservableObject {
    @Published var foundryActor: FoundryActor?
    var userActor: FoundryUserActor
    
    let abilityNameMapping: [String: String] = [
        "str": "Strength",
        "con": "Constitution",
        "wis": "Wisdome",
        "cha": "Charisma",
        "dex": "Dexterity",
        "int": "Intelligence",
    ]
    
    let skillNameMapping: [String: String] = [
        "acr": "Acrobatics",
        "ani": "Animal Handling",
        "arc": "Arcana",
        "ath": "Athletics",
        "dec": "Deception",
        "his": "History",
        "ins": "Insight",
        "inv": "Investigation",
        "itm": "Intemidation",
        "med": "Medicine",
        "nat": "Nature",
        "per": "Persuasion",
        "prc": "Perception",
        "prf": "Performance",
        "rel": "Religion",
        "slt": "Sleight of Hand",
        "ste": "Stealth",
        "sur": "Survival",
    ]
    
    init(userActor: FoundryUserActor) {
        self.userActor = userActor;
        fetchActorData(actorId: self.userActor.actorId)
    }
    
    func fetchActorData(actorId: String) {
        DispatchQueue.main.async {
            FoundrySocketIOManager.sharedInstance.getActorData(actorId: actorId) { actor in
                self.foundryActor = actor;
            }
        }
    }
    
    func getClassInfo() -> String {
        var classInfo = ""
        for data in foundryActor!.actor.actorData.classes {
            classInfo += data.name + " " + String(data.levels)
            classInfo += "/"
        }
        classInfo.removeLast()
        return classInfo
    }
    
    func getAbilities() -> [ActorAbility] {
        var abilityMap: [ActorAbility] = []
        if let actor = foundryActor {
            actor.actor.actorData.abilities.sorted( by: { $0.0 < $1.0 }).forEach { (key: String, value: Ability) in
                abilityMap.append(ActorAbility(id: key, ability: value))
            }
        }
        return abilityMap
    }
    
    func getSkills() -> [ActorSkill] {
        var skillMap: [ActorSkill] = []
        if let actor = foundryActor {
            actor.actor.actorData.skills.sorted( by: { $0.0 < $1.0 }).forEach { (key: String, value: Skill) in
                skillMap.append(ActorSkill(id: key, skill: value))
            }
        }
        return skillMap
    }
    
    func getWalkSpeed() -> String {
        return String(foundryActor!.actor.actorData.attributes.movement.walk) + foundryActor!.actor.actorData.attributes.movement.units
    }
    
    func getHitPoints() -> String {
        return "HIT POINTS: " + String(foundryActor!.actor.actorData.attributes.hp.value) + "/" + String(foundryActor!.actor.actorData.attributes.hp.max)
    }
    
    func getInitiativeBonus() -> String {
        return "INITIATIVE: +" + String(foundryActor!.actor.actorData.attributes.attributesInit.mod)
    }
    
    func getArmorClass() -> String {
        return "AC: " + String(foundryActor!.actor.actorData.attributes.ac.value)
    }
    
    func getProficiencyBonus() -> String {
        return "PROF +" + String(foundryActor!.actor.actorData.attributes.prof)
    }
    
    func rollAbility(actorAbility: ActorAbility, isSave: Bool, advantage: Bool, disadvantage: Bool) {
        let roll = AbilityRollModel(actorId: self.userActor.actorId, ability: actorAbility.id, advantage: advantage, disadvantage: disadvantage, isSave: isSave, result: 0)
        DispatchQueue.main.async {
            FoundrySocketIOManager.sharedInstance.rollAbility(abilityRoll: roll) { abilityRollModel in
                if let rollResult = abilityRollModel {
                    print(rollResult.result)
                }
            }
        }
    }
    
    func rollSkillCheck(actorSkill: ActorSkill, advantage: Bool, disadvantage: Bool) {
        let roll = SkillRollModel(actorId: self.userActor.actorId, skill: actorSkill.id, advantage: advantage, disadvantage: disadvantage, result: 0)
        DispatchQueue.main.async {
            FoundrySocketIOManager.sharedInstance.rollSkill(skillRoll: roll) { skillRollModel in
                if let rollResult = skillRollModel {
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

struct ActorSkill: Identifiable {
    var id: String
    var skill: Skill
}
