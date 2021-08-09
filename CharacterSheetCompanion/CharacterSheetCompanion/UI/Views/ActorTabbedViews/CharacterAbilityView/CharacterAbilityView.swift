//
//  CharacterView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterAbilityView: View {
    @ObservedObject var characterAbilityVM: CharacterAbilityViewModel

    var body: some View {
        ZStack {
            ScrollView {
                Group {
                    Section(header: Text("Abilities")) {
                        HStack {
                            AbilityView(characterAbilityVM: characterAbilityVM, ability: characterAbilityVM.abilities[0])
                            AbilityView(characterAbilityVM: characterAbilityVM, ability: characterAbilityVM.abilities[1])
                            AbilityView(characterAbilityVM: characterAbilityVM, ability: characterAbilityVM.abilities[2])
                        }
                        .frame(minHeight: 150, maxHeight: 150)
                        .padding([.leading, .trailing], 5)

                        HStack {
                            AbilityView(characterAbilityVM: characterAbilityVM, ability: characterAbilityVM.abilities[3])
                            AbilityView(characterAbilityVM: characterAbilityVM, ability: characterAbilityVM.abilities[4])
                            AbilityView(characterAbilityVM: characterAbilityVM, ability: characterAbilityVM.abilities[5])
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
                            AbilityView(characterAbilityVM: characterAbilityVM, isSave: true, ability: characterAbilityVM.abilities[0])
                            AbilityView(characterAbilityVM: characterAbilityVM, isSave: true, ability: characterAbilityVM.abilities[1])
                            AbilityView(characterAbilityVM: characterAbilityVM, isSave: true, ability: characterAbilityVM.abilities[2])
                        }
                        .frame(minHeight: 150, maxHeight: 150)
                        .padding([.leading, .trailing], 5)

                        HStack {
                            AbilityView(characterAbilityVM: characterAbilityVM, isSave: true, ability: characterAbilityVM.abilities[3])
                            AbilityView(characterAbilityVM: characterAbilityVM, isSave: true, ability: characterAbilityVM.abilities[4])
                            AbilityView(characterAbilityVM: characterAbilityVM, isSave: true, ability: characterAbilityVM.abilities[5])
                        }
                        .frame(minHeight: 150, maxHeight: 150)
                        .padding([.leading, .trailing], 5)
                    }
                }
            }
        }
    }
}

#if DEBUG
    struct CharacterAbilityView_Previews: PreviewProvider {
        static var previews: some View {
            CharacterAbilityView(characterAbilityVM: CharacterAbilityViewModel(abilities: AbilityModel.mockedData))
        }
    }
#endif
