//
//  CharacterViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation

class CharacterSpellViewModel: ObservableObject {
    @Published var foundryActor: ActorModel
    
    var spellLevelMapping: [Int: String] = [
        0: "Cantrip",
        1: "1st Level",
        2: "2nd Level",
        3: "3rd Level",
        4: "4th Level",
        5: "5th Level",
        6: "6th Level",
        7: "7th Level",
        8: "8th Level",
        9: "9th Level"
    ]
    
    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor;
    }
    
    func getSpellCategories() -> [SpellCategory] {
        var spells: [SpellCategory] = []
        spellLevelMapping.sorted( by: { $0.0 < $1.0 }).forEach { (key: Int, value: String) in
            let spellsForLevel = getSpellForLevel(spellLevel: key)
            if !spellsForLevel.isEmpty {
                spells.append(SpellCategory(id: value, items: spellsForLevel))
            }
        }
        return spells
    }
    
    func getSpellForLevel(spellLevel: Int) -> [SpellSummary] {
        var spellSummaries: [SpellSummary] = []
        for spell in foundryActor.actor.actorItems.spells {
            if let sLevel = spell.data.level {
                if(sLevel == spellLevel) {
                    spellSummaries.append(SpellSummary(id: spell.id, img: spell.img, name: spell.name, description: spell.data.dataDescription.value, actionType: spell.data.actionType, quantity: spell.data.uses?.value))
                }
            }
        }
        return spellSummaries
    }
    
    func hasAttack(spellSummary: SpellSummary) -> Bool {
        if let actionType = spellSummary.actionType {
            return actionType == "mwak" || actionType == "rwak" || actionType == "msak" || actionType == "rsak"
        }
        return false
    }
    
    func displayItem(spellSummary: SpellSummary) {
        let displayItem = ItemDisplayModel(actorId: foundryActor.actor.id, itemId: spellSummary.id)
        FoundrySocketIOManager.sharedInstance.displayItemCard(displayItem: displayItem)
    }
}

struct SpellCategory: Identifiable {
    var id: String
    var items: [SpellSummary]
}

struct SpellSummary: Identifiable, Hashable {
    var id: String
    var img: String
    var name: String
    var description: String
    
    var actionType: String?
    var quantity: Int?
    
    static func ==(lhs: SpellSummary, rhs: SpellSummary) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
