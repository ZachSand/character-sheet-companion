//
//  CharacterView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterAbilityView: View {
    @ObservedObject var characterAbilityVM: CharacterAbilityViewModel
    var foundryActor: ActorModel

    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor
        characterAbilityVM = CharacterAbilityViewModel(foundryActor: foundryActor)
    }

    var body: some View {
        ZStack {
            ScrollView {
                let abilities = characterAbilityVM.getAbilities()
                Group {
                    Section(header: Text("Abilities")) {
                        HStack {
                            AbilityView(characterAbilityVM: characterAbilityVM, ability: abilities[0])
                            AbilityView(characterAbilityVM: characterAbilityVM, ability: abilities[1])
                            AbilityView(characterAbilityVM: characterAbilityVM, ability: abilities[2])
                        }
                        .frame(minHeight: 150, maxHeight: 150)
                        .padding([.leading, .trailing], 5)

                        HStack {
                            AbilityView(characterAbilityVM: characterAbilityVM, ability: abilities[3])
                            AbilityView(characterAbilityVM: characterAbilityVM, ability: abilities[4])
                            AbilityView(characterAbilityVM: characterAbilityVM, ability: abilities[5])
                        }
                        .frame(minHeight: 150, maxHeight: 150)
                        .padding([.leading, .trailing], 5)
                    }
                }

                Group {
                    Spacer()
                    Divider()

                    Section(header: Text("Saving Throws")) {
                        HStack {
                            AbilityView(characterAbilityVM: characterAbilityVM, isSave: true, ability: abilities[0])
                            AbilityView(characterAbilityVM: characterAbilityVM, isSave: true, ability: abilities[1])
                            AbilityView(characterAbilityVM: characterAbilityVM, isSave: true, ability: abilities[2])
                        }
                        .frame(minHeight: 150, maxHeight: 150)
                        .padding([.leading, .trailing], 5)

                        HStack {
                            AbilityView(characterAbilityVM: characterAbilityVM, isSave: true, ability: abilities[3])
                            AbilityView(characterAbilityVM: characterAbilityVM, isSave: true, ability: abilities[4])
                            AbilityView(characterAbilityVM: characterAbilityVM, isSave: true, ability: abilities[5])
                        }
                        .frame(minHeight: 150, maxHeight: 150)
                        .padding([.leading, .trailing], 5)
                    }
                }

                Group {
                    Spacer()
                    Divider()

                    Section(header: Text("Senses")) {
                        ForEach(characterAbilityVM.getSenses(), id: \.self) { sense in
                            Text(sense)
                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                }

                Group {
                    Spacer()
                    Divider()

                    Section(header: Text("Languages")) {
                        ForEach(characterAbilityVM.getLanguages(), id: \.self) { language in
                            Text(language)
                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
    }
}
