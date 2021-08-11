//
//  ActorSpellOverview.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import Foundation

struct ActorSpellSlotModel: Codable, Identifiable, Hashable {
    var id: String
    var spellLevel: Int
    var spellLevelLabel: String
    var maxSpellSlots: Int
    var currentSpellSlots: Int
    var isPact: Bool
    var spells: [ActorSpellModel]
}

#if DEBUG
    extension ActorSpellSlotModel {
        static let mockedData = [
            ActorSpellSlotModel(id: "0", spellLevel: 0, spellLevelLabel: "Cantrip", maxSpellSlots: 0, currentSpellSlots: 0, isPact: false, spells: [ActorSpellModel.mockedData[0]]),
            ActorSpellSlotModel(id: "1", spellLevel: 1, spellLevelLabel: "1st Level", maxSpellSlots: 2, currentSpellSlots: 1, isPact: false, spells: [ActorSpellModel.mockedData[1]]),
            ActorSpellSlotModel(id: "2", spellLevel: 2, spellLevelLabel: "Pact Magic - 2nd Level", maxSpellSlots: 2, currentSpellSlots: 1, isPact: true, spells: [ActorSpellModel.mockedData[2]]),
            ActorSpellSlotModel(id: "3", spellLevel: 3, spellLevelLabel: "3rd Level", maxSpellSlots: 1, currentSpellSlots: 1, isPact: false, spells: [ActorSpellModel.mockedData[3]]),
            ActorSpellSlotModel(id: "4", spellLevel: 4, spellLevelLabel: "4th Level", maxSpellSlots: 2, currentSpellSlots: 0, isPact: false, spells: [ActorSpellModel.mockedData[4]]),
            ActorSpellSlotModel(id: "5", spellLevel: 5, spellLevelLabel: "5th Level", maxSpellSlots: 3, currentSpellSlots: 2, isPact: false, spells: [ActorSpellModel.mockedData[5]]),
            ActorSpellSlotModel(id: "6", spellLevel: 6, spellLevelLabel: "6th Level", maxSpellSlots: 4, currentSpellSlots: 2, isPact: false, spells: [ActorSpellModel.mockedData[6]]),
            ActorSpellSlotModel(id: "7", spellLevel: 7, spellLevelLabel: "7th Level", maxSpellSlots: 5, currentSpellSlots: 1, isPact: false, spells: [ActorSpellModel.mockedData[7]]),
            ActorSpellSlotModel(id: "8", spellLevel: 8, spellLevelLabel: "8th Level", maxSpellSlots: 2, currentSpellSlots: 2, isPact: false, spells: [ActorSpellModel.mockedData[8]]),
            ActorSpellSlotModel(id: "9", spellLevel: 9, spellLevelLabel: "9th Level", maxSpellSlots: 1, currentSpellSlots: 0, isPact: false, spells: [ActorSpellModel.mockedData[9]]),
        ]
    }
#endif
