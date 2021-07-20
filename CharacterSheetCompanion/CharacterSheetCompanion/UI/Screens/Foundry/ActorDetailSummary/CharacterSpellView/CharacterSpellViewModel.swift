//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation

class CharacterSpellViewModel: ObservableObject {
    @Published var foundryActor: FoundryActor
    
    init(foundryActor: FoundryActor) {
        self.foundryActor = foundryActor;
    }
    
    func getSpells() -> [SpellInfo] {
        var spells: [SpellInfo] = []
        for spell in foundryActor.actor.actorItems.spells {
            spells.append(SpellInfo(id: spell.id, name: spell.name))
        }
        return spells
    }
}

struct SpellInfo: Identifiable {
    var id: String
    var name: String
}
