//
//  CharacterOverviewView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/21/21.
//

import SwiftUI

struct CharacterOverviewView: View {
    @ObservedObject var characterOverviewVM: CharacterOverviewViewModel
    var foundryActor: ActorModel
    
    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor
        characterOverviewVM = CharacterOverviewViewModel(foundryActor: foundryActor)
    }
    
    var body: some View {
        VStack {
            HStack{
                Text(characterOverviewVM.getAC())
                Spacer()
                Text(foundryActor.actor.name).font(.headline)
                Spacer()
                Text(characterOverviewVM.getHealth())
            }
            HStack{
                Spacer()
                if let imageData = Data(base64Encoded: foundryActor.actor.img) {
                    if let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 75, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
                Spacer()
            }
            HStack {
                Text(characterOverviewVM.getProficiencyBonus())
                Spacer()
                Text(characterOverviewVM.getClassInfo())
                Spacer()
                Text(characterOverviewVM.getInitiativeBonus())
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.orange, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
}
