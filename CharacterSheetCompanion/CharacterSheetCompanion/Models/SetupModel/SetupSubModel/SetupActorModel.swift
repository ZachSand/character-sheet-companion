//
//  UserActorModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import Foundation

struct SetupActorModel: Codable, Identifiable, Hashable {
    var id: String
    var name: String
}

#if DEBUG
    extension SetupActorModel {
        static let mockedData: [SetupActorModel] = [
            SetupActorModel(id: "1", name: "Jester Lavorre"),
            SetupActorModel(id: "2", name: "Mollymauk \"Molly\" Tealeaf"),
            SetupActorModel(id: "3", name: "Caduceus Clay"),
            SetupActorModel(id: "4", name: "Yasha Nydoorin"),
            SetupActorModel(id: "5", name: "Caleb Widogast"),
            SetupActorModel(id: "6", name: "Beauregard \"Beau\" Lionett"),
            SetupActorModel(id: "7", name: "Nott the Brave"),
            SetupActorModel(id: "8", name: "Veth Brenatto"),
            SetupActorModel(id: "9", name: "Fjord"),
        ]
    }
#endif
