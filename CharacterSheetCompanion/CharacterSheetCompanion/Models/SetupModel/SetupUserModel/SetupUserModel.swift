//
//  UserModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import Foundation

struct SetupUserModel: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var isActive: Bool
    var actors: [SetupActorModel]?
}

#if DEBUG
    extension SetupUserModel {
        static let mockedData: [SetupUserModel] = [
            SetupUserModel(id: "1", name: "Matther Mercer", isActive: true, actors: SetupActorModel.mockedData),
            SetupUserModel(id: "2", name: "Laura Bailey", isActive: true, actors: SetupActorModel.mockedData),
            SetupUserModel(id: "3", name: "Taliesin Jaffe", isActive: true, actors: SetupActorModel.mockedData),
            SetupUserModel(id: "4", name: "Ashley Johnson", isActive: true, actors: SetupActorModel.mockedData),
            SetupUserModel(id: "5", name: "Liam O'Brien", isActive: true, actors: SetupActorModel.mockedData),
            SetupUserModel(id: "6", name: "Marisha Ray", isActive: true, actors: SetupActorModel.mockedData),
            SetupUserModel(id: "7", name: "Sam Riegel", isActive: true, actors: SetupActorModel.mockedData),
            SetupUserModel(id: "8", name: "Travis Willingham", isActive: true, actors: SetupActorModel.mockedData),
        ]
    }
#endif
