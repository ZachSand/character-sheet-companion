//
//  CharacterView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterSkillView: View {
    @ObservedObject var characterSkillVM: CharacterSkillViewModel
    var foundryActor: ActorModel
    
    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor
        characterSkillVM = CharacterSkillViewModel(foundryActor: foundryActor)
    }
    
    var body: some View {
        VStack {
            CharacterOverviewView(foundryActor: foundryActor)
            Text("Skills")
            List(characterSkillVM.getSkills()) {skill in
                Button(action: {
                    characterSkillVM.rollSkillCheck(actorSkill: skill, advantage: false, disadvantage: false)
                })
                {
                    Text(characterSkillVM.getSkillText(skillId: skill.id))
                }
            }
        }
    }
}
