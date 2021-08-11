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
    var setupWorldDataListener: WorldDataListener?
    var userActorListener: ActorListener?

    init() {
        do {
            try usersListener = FoundrySocketIOManager.sharedInstance.getListener()
            try setupWorldDataListener = FoundrySocketIOManager.sharedInstance.getListener()
            try userActorListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
        fetchUsers()
        fetchWorldData()
        fetchUserActors()
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
        if let listener = setupWorldDataListener {
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

    func setActor(actor: ActorModel) {
        FoundrySocketIOManager.sharedInstance.actor = actor
    }

    func setUser(user: UserModel) {
        FoundrySocketIOManager.sharedInstance.user = user
    }
}
