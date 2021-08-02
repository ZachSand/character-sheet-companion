//
//  UserActorPickerView.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import Foundation

class WorldUserActorViewModel: ObservableObject {
    @Published var worldData: WorldDataModel?
    @Published var foundryUserActors: [UserActorModel]?
    @Published var foundryUsers: [UserModel]?
    
    init() {
        DispatchQueue.main.async {
            self.fetchUsers()
        }
        DispatchQueue.main.async {
            self.fetchWorldData()
        }
        DispatchQueue.main.async {
            self.fetchUserActors()
        }
    }
    
    func fetchUsers() {
        FoundrySocketIOManager.sharedInstance.getUsers() { users in
            self.foundryUsers = users
        }
    }
    
    func fetchWorldData() {
        FoundrySocketIOManager.sharedInstance.getWorldData { worldData in
            self.worldData = worldData
        }
    }
    
    func fetchUserActors() {
        FoundrySocketIOManager.sharedInstance.getUserActors { userActors in
            DispatchQueue.main.async {
                self.foundryUserActors = userActors
            }
        }
    }
}
