//
//  Movement.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import Foundation

struct ActorMovementModel: Codable {
    var burrow: Int
    var climb: Int
    var fly: Int
    var hover: Bool
    var swim: Int
    var units: String
    var walk: Int
}
