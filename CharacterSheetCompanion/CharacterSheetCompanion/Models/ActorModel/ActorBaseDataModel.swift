//
//  ActorBaseData.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import Foundation

struct ActorBaseDataModel: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var image: Data?
}
