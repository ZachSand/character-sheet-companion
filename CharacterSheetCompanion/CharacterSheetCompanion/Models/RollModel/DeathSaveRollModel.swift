//
//  DeathSaveRollModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/20/21.
//

import Foundation

struct DeathSaveRollModel: Codable {
    var actorId: String
    var advantage: Bool
    var disadvantage: Bool
    var result: Int
}
