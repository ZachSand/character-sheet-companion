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
    
    var usersListener: UsersListener?
    var worldDataListener: WorldDataListener?
    var userActorListener: UserActorListener?
    
    init() {
        do {
            try usersListener = FoundrySocketIOManager.sharedInstance.getListener()
            try worldDataListener = FoundrySocketIOManager.sharedInstance.getListener()
            try userActorListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {
            
        }
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
        if let listener = usersListener {
            listener.getUsers() { users in
                self.foundryUsers = users
            }
        }
    }
    
    func fetchWorldData() {
        if let listener = worldDataListener {
            listener.getWorldData { worldData in
                self.worldData = worldData
            }
        }
    }
    
    func fetchUserActors() {
        if let listener = userActorListener {
            listener.getUserActors { userActors in
                DispatchQueue.main.async {
                    self.foundryUserActors = userActors
                }
            }
        }
    }
}
