//
//  UserModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import Foundation

struct UserModel: Decodable, Hashable {
    var userId: String
    var userName: String
    var isActive: Bool
}

extension UserModel: Identifiable {
    var id: String { return userId }
}
