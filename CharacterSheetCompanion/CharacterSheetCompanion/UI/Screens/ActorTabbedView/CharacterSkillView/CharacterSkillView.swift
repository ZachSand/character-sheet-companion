//
//  CharacterView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterSkillView: View {
    @ObservedObject var characterSkillVM: CharacterSkillViewModel
    var foundryActor: ActorDataModel

    init(foundryActor: ActorDataModel) {
        self.foundryActor = foundryActor
        characterSkillVM = CharacterSkillViewModel(foundryActor: foundryActor)
    }

    var body: some View {
        VStack {
            HStack {
                Text("Prof")
                    .font(.system(size: 10))
                    .frame(width: 30)
                Text("Skill")
                    .font(.system(size: 10))
                    .frame(width: 125)
                Text("Mod")
                    .font(.system(size: 10))
                    .frame(width: 30)
                Text("Bonus")
                    .font(.system(size: 10))
                    .frame(width: 30)
                Text("Passive")
                    .font(.system(size: 10))
                    .frame(width: 45)
            }
            Divider()
            List(characterSkillVM.getSkills()) { skill in
                HStack {
                    if skill.prof {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 30, height: 15)
                    } else {
                        Circle()
                            .strokeBorder(Color.black)
                            .background(Circle().fill(Color.white))
                            .frame(width: 30, height: 15)
                    }
                    Text(skill.name)
                        .frame(width: 125, height: 50, alignment: .leading)
                    Text(skill.ability)
                        .textCase(.uppercase)
                        .frame(width: 40, height: 50, alignment: .center)
                    Button(action: {
                        characterSkillVM.rollSkillCheck(actorSkill: skill, advantage: false, disadvantage: false)
                    }) {
                        Text(skill.modifier)
                            .frame(width: 30, height: 50, alignment: .trailing)
                    }
                    Text(skill.passive)
                        .frame(width: 45, height: 50, alignment: .trailing)
                }
            }
        }
    }
}
