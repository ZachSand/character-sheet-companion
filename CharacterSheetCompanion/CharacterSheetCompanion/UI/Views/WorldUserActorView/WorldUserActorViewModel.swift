//
//  UserActorPickerView.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import Foundation

class WorldUserActorViewModel: ObservableObject {
    @Published var users: [UserModel]?
    @Published var actors: [ActorModel] = []

    var usersListener: SetupUsersListener?

    init() {
        do {
            try usersListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
        fetchUsers()
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

    func completeSetup(user: UserModel, actor: ActorModel) {
        FoundrySocketIOManager.sharedInstance.finishSetup(user: user, actor: actor)
    }

    func updateActors(selectedUser: UserModel) {
        if let users = users?.filter({ user in
            user.id == selectedUser.id
        }) {
            if users.count == 1 {
                if let userActors = users[0].actors {
                    actors = userActors
                }
            }
        }
    }
}
