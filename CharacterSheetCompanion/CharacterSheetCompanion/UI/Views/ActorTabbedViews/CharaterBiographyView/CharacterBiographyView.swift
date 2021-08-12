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
            if let biography = characterBiographyVM.biography {
                ScrollView {
                    Section(header: Text("Appearance").font(.subheadline)) {
                        Text(biography.appearance)
                    }

                    Divider()
                    Section(header: Text("Personality Traits").font(.subheadline)) {
                        Text(biography.personalityTraits)
                    }

                    Divider()
                    Section(header: Text("Ideals").font(.subheadline)) {
                        Text(biography.ideals)
                    }

                    Divider()
                    Section(header: Text("Bonds").font(.subheadline)) {
                        Text(biography.bonds)
                    }

                    Divider()
                    Section(header: Text("Flaws").font(.subheadline)) {
                        Text(biography.flaws)
                    }

                    Section(header: Text("Biography").font(.subheadline)) {
                        Text(biography.biography)
                    }
                }
            }
        }
    }
}

#if DEBUG
    struct CharacterBiographyView_Previews: PreviewProvider {
        static let characterBiographyVM: CharacterBiographyViewModel = {
            let characterBiographyVM = CharacterBiographyViewModel()
            characterBiographyVM.biography = ActorBiographyModel.mockedData
            return characterBiographyVM
        }()

        static var previews: some View {
            CharacterBiographyView(characterBiographyVM: characterBiographyVM)
        }
    }
#endif
