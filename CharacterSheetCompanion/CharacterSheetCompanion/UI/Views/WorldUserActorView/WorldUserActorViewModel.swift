//
//  UserActorPickerView.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import Foundation

class WorldUserActorViewModel: ObservableObject {
    @Published var worldData: WorldDataModel?
    @Published var actors: [ActorModel]?
    @Published var users: [UserModel]?

    var usersListener: UsersListener?
    var worldDataListener: WorldDataListener?
    var userActorListener: ActorListener?

    init() {
        do {
            try usersListener = FoundrySocketIOManager.sharedInstance.getListener()
            try worldDataListener = FoundrySocketIOManager.sharedInstance.getListener()
            try userActorListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
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
            DispatchQueue.main.async {
                listener.getUsers { users in
                    self.users = users
                }
            }
        }
    }

    func fetchWorldData() {
        if let listener = worldDataListener {
            DispatchQueue.main.async {
                listener.getWorldData { worldData in
                    self.worldData = worldData
                }
            }
        }
    }

    func fetchUserActors() {
        if let listener = userActorListener {
            DispatchQueue.main.async {
                listener.getActors { actors in
                    self.actors = actors
                }
            }
        }
    }
}
