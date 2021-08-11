//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation

class CharacterSkillViewModel: ObservableObject {
    @Published var skills: [ActorSkillModel]

    var skillListener: SkillListener?

    init(skills: [ActorSkillModel]) {
        self.skills = skills
        do {
            try skillListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func rollSkillCheck(skill: ActorSkillModel, advantage: Bool, disadvantage: Bool) {
        if let listener = skillListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let roll = SkillRollModel(actorId: actor.id, skill: skill.id, advantage: advantage, disadvantage: disadvantage, result: 0)
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
