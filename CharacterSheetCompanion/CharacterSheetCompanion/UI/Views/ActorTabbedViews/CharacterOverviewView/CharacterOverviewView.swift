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
    var actorOverview: ActorOverviewModel

    init(actorOverview: ActorOverviewModel) {
        self.actorOverview = actorOverview
        characterOverviewVM = CharacterOverviewViewModel(actorOverview: actorOverview)
    }

    var body: some View {
        VStack {
            HStack {
                Text(characterOverviewVM.getCharacterArmorClass())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 5)

                Text(characterOverviewVM.getCharacterName())
                    .bold()
                    .font(.system(size: 12))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)

                Button {
                    showHpSheet.toggle()
                } label: {
                    Text(characterOverviewVM.getHealth())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 5)
                }.sheet(isPresented: $showHpSheet, content: {
                    HpModifierSheet()
                })
            }.padding([.all], 0)

            HStack {
                Button {} label: {
                    Text("Conditions")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
                }

                getActorImage()
                    .resizable()
                    .frame(width: 75, height: 50, alignment: .center)

                Button {} label: {
                    Text("Rest")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 5)
                }
            }.padding([.all], 0)

            HStack {
                Text(characterOverviewVM.getProficiencyBonus())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 5)

                Text(characterOverviewVM.getClassInfo()).font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .center)

                Button {
                    characterOverviewVM.rollInitiative()
                } label: {
                    Text(characterOverviewVM.getInitiativeBonus())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 5)
                }
            }.padding([.all], 0)
        }
    }

    func getActorImage() -> Image {
        if let imageData = actorOverview.imageData, let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.fill")
        }
    }
}

struct HpModifierSheet: View {
    var body: some View {
        Text("Make some HP changes here!")
    }
}

#if DEBUG
    struct CharacterOverviewView_Previews: PreviewProvider {
        static var previews: some View {
            CharacterOverviewView(actorOverview: ActorOverviewModel.mockedData)
        }
    }
#endif
