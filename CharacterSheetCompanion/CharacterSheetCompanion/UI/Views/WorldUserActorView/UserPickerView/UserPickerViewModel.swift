//
//  UsersPickerViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/18/21.
//

import Foundation

class UserPickerViewModel: ObservableObject {
    @Published var users: [SetupUserModel]?

    private var usersListener: SetupUsersListener?

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
}
