//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Combine
import Foundation

class CharacterSkillViewModel: ObservableObject {
    @Published var skills: [ActorSkillModel]?

    var subscription = Set<AnyCancellable>()

    var skillListener: RollSkillListener?
    var skillsListener: ActorSkillListener?

    init() {
        do {
            try skillListener = FoundrySocketIOManager.sharedInstance.getListener()
            try skillsListener = FoundrySocketIOManager.sharedInstance.getListener()
            skillsListener?.skillsPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.skills = model
                })
                .store(in: &subscription)
        } catch {}
    }

    func rollSkillCheck(skill: ActorSkillModel, advantage: Bool, disadvantage: Bool) {
        if let listener = skillListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let roll = SkillRollModel(actorId: actor.id, skill: skill.id, advantage: advantage, disadvantage: disadvantage, result: 0)
            DispatchQueue.main.async {
                listener.rollSkill(skillRoll: roll) { skillRollModel in
                    print(skillRollModel)
                }
            }
        }
    }
}
