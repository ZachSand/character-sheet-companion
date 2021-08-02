//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation

class CharacterSkillViewModel: ObservableObject {
    @Published var foundryActor: ActorModel
    
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
    
    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor;
    }
    
    func getSkills() -> [ActorSkill] {
        var skillMap: [ActorSkill] = []
        foundryActor.actor.actorData.skills.sorted( by: { $0.0 < $1.0 }).forEach { (key: String, value: Skill) in
            skillMap.append(ActorSkill(id: key,
                name: getSkillText(skillId: key),
                ability: value.ability,
                modifier: getModifierText(modifier: value.total),
                passive: String(value.passive),
                prof: value.prof > 0))
        }
        return skillMap
    }
    
    func getSkillText(skillId: String) -> String {
        if let skillText = skillNameMapping[skillId] {
            return skillText
        }
        return "Unknown"
    }
    
    func getModifierText(modifier: Int) -> String {
        if modifier > 0 {
            return "+\(modifier)"
        }
        return String(modifier)
    }
    
    func rollSkillCheck(actorSkill: ActorSkill, advantage: Bool, disadvantage: Bool) {
        let roll = SkillRollModel(actorId: self.foundryActor.actor.id, skill: actorSkill.id, advantage: advantage, disadvantage: disadvantage, result: 0)
        DispatchQueue.main.async {
            FoundrySocketIOManager.sharedInstance.rollSkill(skillRoll: roll) { skillRollModel in
                if let rollResult = skillRollModel {
                    print(rollResult.result)
                }
            }
        }
    }
}

struct ActorSkill: Identifiable {
    var id: String
    var name: String
    var ability: String
    var modifier: String
    var passive: String
    var prof: Bool
}
