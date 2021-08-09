//
//  CharacterBiographyView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/3/21.
//

import SwiftUI

struct CharacterBiographyView: View {
    @ObservedObject var characterBiographyVM: CharacterBiographyViewModel

    var body: some View {
        VStack {
            ScrollView {
                Section(header: Text("Appearance").font(.subheadline)) {
                    Text(characterBiographyVM.biography.appearance)
                }

                Divider()
                Section(header: Text("Personality Traits").font(.subheadline)) {
                    Text(characterBiographyVM.biography.personalityTraits)
                }

                Divider()
                Section(header: Text("Ideals").font(.subheadline)) {
                    Text(characterBiographyVM.biography.ideals)
                }

                Divider()
                Section(header: Text("Bonds").font(.subheadline)) {
                    Text(characterBiographyVM.biography.bonds)
                }

                Divider()
                Section(header: Text("Flaws").font(.subheadline)) {
                    Text(characterBiographyVM.biography.flaws)
                }

                Section(header: Text("Biography").font(.subheadline)) {
                    Text(characterBiographyVM.biography.biography)
                }
            }
        }
    }
}

#if DEBUG
    struct CharacterBiographyView_Previews: PreviewProvider {
        static var previews: some View {
            CharacterBiographyView(characterBiographyVM: CharacterBiographyViewModel(biography: ActorBiographyModel.mockedData))
        }
    }
#endif
