//
//  CharacterView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterSpellView: View {
    @ObservedObject var characterSpellVM: CharacterSpellViewModel
    var foundryActor: FoundryActor
    
    init(foundryActor: FoundryActor) {
        self.foundryActor = foundryActor
        characterSpellVM = CharacterSpellViewModel(foundryActor: foundryActor)
    }
    
    var body: some View {
        VStack {
            List(characterSpellVM.getSpells()) {spell in
                Text(spell.name)
            }
        }
    }
}
