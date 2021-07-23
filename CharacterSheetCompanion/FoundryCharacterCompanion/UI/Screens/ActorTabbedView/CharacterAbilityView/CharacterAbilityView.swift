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
            Text("Attributes")
            List(characterAbilityVM.getAbilities()) {ability in
                Button(action: {
                    characterAbilityVM.rollAbility(actorAbility: ability, isSave: false, advantage: false, disadvantage: false)
                })
                {
                    Text(ability.id)
                }
            }
        }
    }
}
