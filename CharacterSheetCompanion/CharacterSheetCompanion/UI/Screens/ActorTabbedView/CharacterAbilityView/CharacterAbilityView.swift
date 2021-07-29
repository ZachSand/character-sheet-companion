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
        VStack {
            CharacterOverviewView(foundryActor: foundryActor)
                .frame(alignment: .top)
            ScrollView {
                
                let abilities = characterAbilityVM.getAbilities()
                Group {
                    Spacer()
                    Divider()
                    
                    Section(header: Text("Abilities")) {
                        HStack {
                            AbilityView(ability: abilities[0])
                            AbilityView(ability: abilities[1])
                            AbilityView(ability: abilities[2])
                        }
                        .frame(maxHeight: 100)
                        HStack {
                            AbilityView(ability: abilities[3])
                            AbilityView(ability: abilities[4])
                            AbilityView(ability: abilities[5])
                        }.frame(maxHeight: 100)
                    }
                }
                
                Group {
                    Spacer()
                    Divider()
                    
                    Section(header: Text("Saving Throws")) {
                        HStack {
                            SavingThrowView(ability: abilities[0])
                            SavingThrowView(ability: abilities[1])
                            SavingThrowView(ability: abilities[2])
                        }
                        .frame(maxHeight: 100)
                        HStack {
                            SavingThrowView(ability: abilities[3])
                            SavingThrowView(ability: abilities[4])
                            SavingThrowView(ability: abilities[5])
                        }.frame(maxHeight: 100)
                    }
                }
                
                Group {
                    Spacer()
                    Divider()
                    
                    Section(header: Text("Senses")) {
                        VStack {
                            ForEach(characterAbilityVM.getSenses(), id: \.self) { sense in
                                Text(sense)
                            }
                        }
                    }
                }
                
                Group {
                    Spacer()
                    Divider()
                    
                    Section(header: Text("Languages")) {
                        VStack {
                            ForEach(foundryActor.actor.actorData.traits.languages.value, id: \.self) { language in
                                Text(language)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SavingThrowView: View {
    @State var ability: ActorAbility
    
    var body: some View {
        GroupBox(label:
            Text(ability.name)
                .font(.system(size: 10))
            .frame(maxWidth: .infinity, alignment: .top)
        ){
            VStack {
                Text(ability.savingMod)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

struct AbilityView: View {
    @State var ability: ActorAbility
    
    var body: some View {
        GroupBox(label:
            Text(ability.name)
                .font(.system(size: 10))
            .frame(maxWidth: .infinity, alignment: .top)
        ){
            VStack {
                Spacer()
                Text(ability.mod)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                Text(ability.total).font(.footnote)
            }
        }
    }
}
