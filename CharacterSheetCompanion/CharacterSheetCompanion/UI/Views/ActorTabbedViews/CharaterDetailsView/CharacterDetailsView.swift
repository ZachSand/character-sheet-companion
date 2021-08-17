//
//  CharacterBiographyView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/3/21.
//

import SwiftUI

struct CharacterDetailsView: View {
    @ObservedObject var characterDetailsVM: CharacterDetailsViewModel

    var body: some View {
        VStack {
            if let details = characterDetailsVM.details {
                ScrollView {
                    Section(header: Text("Appearance").font(.subheadline)) {
                        Text(details.appearance)
                    }

                    Divider()
                    Section(header: Text("Personality Traits").font(.subheadline)) {
                        Text(details.personalityTraits)
                    }

                    Divider()
                    Section(header: Text("Ideals").font(.subheadline)) {
                        Text(details.ideals)
                    }

                    Divider()
                    Section(header: Text("Bonds").font(.subheadline)) {
                        Text(details.bonds)
                    }

                    Divider()
                    Section(header: Text("Flaws").font(.subheadline)) {
                        Text(details.flaws)
                    }

                    Section(header: Text("Biography").font(.subheadline)) {
                        Text(details.biography)
                    }
                }
            }
        }
    }
}

#if DEBUG
    struct CharacterDetailsView_Previews: PreviewProvider {
        static let characterDetailsVM: CharacterDetailsViewModel = {
            let characterDetailsVM = CharacterDetailsViewModel()
            characterDetailsVM.details = ActorDetailsModel.mockedData
            return characterDetailsVM
        }()

        static var previews: some View {
            CharacterDetailsView(characterDetailsVM: characterDetailsVM)
        }
    }
#endif
