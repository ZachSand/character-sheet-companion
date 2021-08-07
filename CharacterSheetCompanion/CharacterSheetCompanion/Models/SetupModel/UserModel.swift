//
//  UserModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import Foundation

struct UserModel: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var isActive: Bool
}

#if DEBUG
    extension UserModel {
        static let mockedData: [UserModel] = [
            UserModel(id: "1", name: "Matther Mercer", isActive: true),
            UserModel(id: "2", name: "Laura Bailey", isActive: true),
            UserModel(id: "3", name: "Taliesin Jaffe", isActive: true),
            UserModel(id: "4", name: "Ashley Johnson", isActive: true),
            UserModel(id: "5", name: "Liam O'Brien", isActive: true),
            UserModel(id: "6", name: "Marisha Ray", isActive: true),
            UserModel(id: "7", name: "Sam Riegel", isActive: true),
            UserModel(id: "8", name: "Travis Willingham", isActive: true),
        ]
    }
#endif
