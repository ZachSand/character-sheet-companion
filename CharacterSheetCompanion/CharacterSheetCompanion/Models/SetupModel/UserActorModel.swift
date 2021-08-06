//
//  UserActorModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import Foundation

struct UserActorModel: Decodable, Hashable {
    var actorId: String
    var name: String
}

extension UserActorModel: Identifiable {
    var id: String { actorId }
}
