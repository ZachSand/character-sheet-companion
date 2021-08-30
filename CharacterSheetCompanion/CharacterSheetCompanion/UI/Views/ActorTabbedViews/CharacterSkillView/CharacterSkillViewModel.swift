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

    private var rollSkillListener = SocketManagerWrapper.sharedInstance.rollListenerWrapper.skillRollListener
    private var skillsListener = SocketManagerWrapper.sharedInstance.actorListenerWrapper.actorSkillsListener
    private var subscription = Set<AnyCancellable>()

    init() {
        skillsListener.modelPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { model in
                self.skills = model?.skills
            })
            .store(in: &subscription)
    }

    func rollSkillCheck(skill: ActorSkillModel, advantage: Bool, disadvantage: Bool) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            rollSkillListener.request(model: SkillRollModel(actorId: actor.id, skill: skill.id, advantage: advantage, disadvantage: disadvantage, result: 0))
        }
    }
}
