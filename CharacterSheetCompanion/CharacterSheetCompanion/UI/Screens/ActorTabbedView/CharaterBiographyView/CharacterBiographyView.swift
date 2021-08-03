//
//  CharacterBiographyView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/3/21.
//

import SwiftUI

struct CharacterBiographyView: View {
    @ObservedObject var characterBiographyVM: CharacterBiographyViewModel
    let foundryActor: ActorModel
    
    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor 
        characterBiographyVM = CharacterBiographyViewModel(foundryActor: foundryActor)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                Section(header: Text("Appearance").font(.subheadline)) {
                    Text(characterBiographyVM.getAppearance())
                }
                
                Divider()
                Section(header: Text("Personality Traits").font(.subheadline)) {
                    Text(characterBiographyVM.getPersonalityTraits())
                }
                
                Divider()
                Section(header: Text("Ideals").font(.subheadline)) {
                    Text(characterBiographyVM.getIdeals())
                }
                
                Divider()
                Section(header: Text("Bonds").font(.subheadline)) {
                    Text(characterBiographyVM.getBonds())
                }
                
                Divider()
                Section(header: Text("Flaws").font(.subheadline)) {
                    Text(characterBiographyVM.getFlaws())
                }
                
                //Divider()
                Section(header: Text("Biography").font(.subheadline)) {
                    Text(characterBiographyVM.getBiography())
                }
            }
        }
    }
}
