//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation

class CharacterSkillViewModel: ObservableObject {
    @Published var skills: [SkillModel]

    var skillListener: SkillListener?

    init(skills: [SkillModel]) {
        self.skills = skills
        do {
            try skillListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func rollSkillCheck(skill: SkillModel, advantage: Bool, disadvantage: Bool) {
        let roll = SkillRollModel(actorId: "", skill: skill.id, advantage: advantage, disadvantage: disadvantage, result: 0)
        if let listener = skillListener {
            DispatchQueue.main.async {
                listener.rollSkill(skillRoll: roll) { skillRollModel in
                    if let rollResult = skillRollModel {
                        print(rollResult.result)
                    }
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
