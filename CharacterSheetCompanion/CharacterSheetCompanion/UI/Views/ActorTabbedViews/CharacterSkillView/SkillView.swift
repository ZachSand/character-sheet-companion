//
//  SkillView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import SwiftUI

struct SkillView: View {
    @ObservedObject var characterSkillVM: CharacterSkillViewModel
    @State var skill: SkillModel

    var body: some View {
        HStack {
            if skill.proficient {
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

            Text(skill.abilityModifier)
                .textCase(.uppercase)
                .frame(width: 40, height: 50)
            Spacer()

            Button(action: {
                characterSkillVM.rollSkillCheck(skill: skill, advantage: false, disadvantage: false)
            }) {
                Text(getModifierText(modifier: skill.bonusModifier))
                    .frame(width: 30, height: 50)
            }
            Spacer()
            Text(String(skill.passiveValue))
                .frame(width: 45, height: 50)
        }
    }

    func getModifierText(modifier: Int) -> String {
        if modifier > 0 {
            return "+\(modifier)"
        }
        return String(modifier)
    }
}

#if DEBUG
    struct SkillView_Previews: PreviewProvider {
        static var previews: some View {
            SkillView(characterSkillVM: CharacterSkillViewModel(skills: SkillModel.mockedData), skill: SkillModel.mockedData[0])
        }
    }
#endif
