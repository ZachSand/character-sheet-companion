//
//  CharacterOverviewView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/21/21.
//

import SwiftUI

struct CharacterOverviewView: View {
    @ObservedObject var characterOverviewVM: CharacterOverviewViewModel
    @State private var showHpSheet = false
    var foundryActor: ActorModel

    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor
        characterOverviewVM = CharacterOverviewViewModel(foundryActor: foundryActor)
    }

    var body: some View {
        VStack {
            HStack {
                Text(characterOverviewVM.getAC())
                Spacer()
                Text(foundryActor.actor.name).font(.headline)
                Spacer()
                Button(characterOverviewVM.getHealth()) {
                    showHpSheet.toggle()
                }.sheet(isPresented: $showHpSheet, content: {
                    HpModifierSheet()
                })
            }
            HStack {
                Button("Conditions") {}
                Spacer()
                if let imageData = Data(base64Encoded: foundryActor.actor.img), let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 75, height: 50, alignment: .center/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                Button("Rest") {}
            }
            HStack {
                Text(characterOverviewVM.getProficiencyBonus())
                Spacer()
                Text(characterOverviewVM.getClassInfo()).font(.footnote)
                Spacer()
                Button(characterOverviewVM.getInitiativeBonus()) {
                    characterOverviewVM.rollInitiative()
                }
            }
        }
    }
}

struct HpModifierSheet: View {
    var body: some View {
        Text("Make some HP changes here!")
    }
}
