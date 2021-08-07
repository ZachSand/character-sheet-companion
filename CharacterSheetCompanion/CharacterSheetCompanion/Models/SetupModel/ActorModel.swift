//
//  UserActorModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import Foundation

struct ActorModel: Codable, Identifiable, Hashable {
    var id: String
    var name: String
}

#if DEBUG
    extension ActorModel {
        static let mockedData: [ActorModel] = [
            ActorModel(id: "1", name: "Jester Lavorre"),
            ActorModel(id: "2", name: "Mollymauk \"Molly\" Tealeaf"),
            ActorModel(id: "3", name: "Caduceus Clay"),
            ActorModel(id: "4", name: "Yasha Nydoorin"),
            ActorModel(id: "5", name: "Caleb Widogast"),
            ActorModel(id: "6", name: "Beauregard \"Beau\" Lionett"),
            ActorModel(id: "7", name: "Nott the Brave"),
            ActorModel(id: "8", name: "Veth Brenatto"),
            ActorModel(id: "9", name: "Fjord"),
        ]
    }
#endif
