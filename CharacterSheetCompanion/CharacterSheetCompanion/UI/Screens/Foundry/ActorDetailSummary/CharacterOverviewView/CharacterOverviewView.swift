//
//  CharacterView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterOverviewView: View {
    @ObservedObject var characterOverviewVM: CharacterOverviewViewModel
    var foundryActor: FoundryActor
    
    init(foundryActor: FoundryActor) {
        self.foundryActor = foundryActor
        characterOverviewVM = CharacterOverviewViewModel(foundryActor: foundryActor)
    }
    
    var body: some View {
        VStack {
            Text("Attributes")
            List(characterOverviewVM.getAbilities()) {ability in
                Button(action: {
                    characterOverviewVM.rollAbility(actorAbility: ability, isSave: false, advantage: false, disadvantage: false)
                })
                {
                    Text(ability.id)
                }
            }
        }
    }
}
