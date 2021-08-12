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

    var usersListener: SetupUsersListener?
    var setupWorldDataListener: SetupWorldDataListener?
    var actorsListener: SetupActorsListener?

    init() {
        do {
            try usersListener = FoundrySocketIOManager.sharedInstance.getListener()
            try setupWorldDataListener = FoundrySocketIOManager.sharedInstance.getListener()
            try actorsListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
        fetchUsers()
        fetchWorldData()
        fetchActors()
    }

    func fetchUsers() {
        if let listener = usersListener {
            DispatchQueue.main.async {
                listener.getUsers { userModels in
                    self.users = userModels
                }
            }
        }
    }

    func fetchWorldData() {
        if let listener = setupWorldDataListener {
            DispatchQueue.main.async {
                listener.getWorldData { worldDataModel in
                    self.worldData = worldDataModel
                }
            }
        }
    }

    func fetchActors() {
        if let listener = actorsListener {
            DispatchQueue.main.async {
                listener.getActors { actorModels in
                    self.actors = actorModels
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
