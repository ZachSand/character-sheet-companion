//
//  ActorSensesModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import Foundation

struct ActorSensesModel: Codable {
    var blindsight: Int
    var darkvision: Int
    var special: String
    var tremorsense: Int
    var truesight: Int
    var units: String
}

#if DEBUG
    extension ActorSensesModel {
        static let mockedData = ActorSensesModel(
            blindsight: 0,
            darkvision: 60,
            special: "",
            tremorsense: 0,
            truesight: 0,
            units: "ft"
        )
    }
#endif
