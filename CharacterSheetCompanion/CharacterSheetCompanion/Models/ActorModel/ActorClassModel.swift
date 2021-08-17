//
//  ActorClassModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import Foundation

struct ActorClassModel: Codable, Identifiable, Hashable {
    var id: String
    var description: String
    var levels: Int
    var subclass: String
}
