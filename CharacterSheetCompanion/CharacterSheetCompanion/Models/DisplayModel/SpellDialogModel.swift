//
//  SpellDialogModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/5/21.
//

import Foundation

struct SpellDialogModel: Codable, Hashable {
    static func == (lhs: SpellDialogModel, rhs: SpellDialogModel) -> Bool {
        lhs.spellId == rhs.spellId
    }

    var spellId: String
    var canCast: Bool
    var hasSlots: Bool
    var label: String
    var level: StringOrInt
}
