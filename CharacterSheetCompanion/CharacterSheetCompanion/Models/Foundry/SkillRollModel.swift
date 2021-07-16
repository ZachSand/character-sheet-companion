//
//  SkillRollModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/16/21.
//

import Foundation

struct SkillRollModel: Codable {
    var actorId: String
    var skill: String
    var advantage: Bool
    var disadvantage: Bool
    var result: Int
}
