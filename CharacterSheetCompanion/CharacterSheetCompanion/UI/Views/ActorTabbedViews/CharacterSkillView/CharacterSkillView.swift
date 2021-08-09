//
//  CharacterView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterSkillView: View {
    @ObservedObject var characterSkillVM: CharacterSkillViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Prof")
                    .font(.system(size: 12))
                    .padding([.leading], 25)
                Spacer()
                Text("Skill")
                    .font(.system(size: 12))
                    .padding([.leading], 0)
                Spacer()
                Text("Mod")
                    .font(.system(size: 12))
                    .padding([.leading], 60)
                Spacer()
                Text("Bonus")
                    .font(.system(size: 12))
                Spacer()
                Text("Passive")
                    .font(.system(size: 12))
                Spacer()
            }
            Divider()
            List(characterSkillVM.skills) { skill in
                SkillView(characterSkillVM: characterSkillVM, skill: skill)
            }
        }
    }
}

#if DEBUG
    struct CharacterSkillView_Previews: PreviewProvider {
        static var previews: some View {
            CharacterSkillView(characterSkillVM: CharacterSkillViewModel(skills: SkillModel.mockedData))
        }
    }
#endif
