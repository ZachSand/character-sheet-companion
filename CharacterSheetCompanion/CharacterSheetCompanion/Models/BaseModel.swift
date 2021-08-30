//
//  BaseModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation

protocol BaseModel: Codable {
    static func getRequestEvent() -> String
    static func getReceiveEvent() -> String
}
