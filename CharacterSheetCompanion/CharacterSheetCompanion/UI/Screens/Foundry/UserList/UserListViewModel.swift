//
//  FoundryUserFetcher.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/13/21.
//

import Foundation

import Foundation

class UserListViewModel: ObservableObject {
    @Published var foundryUsers: [FoundryUser]?
    
    init() {
        DispatchQueue.main.async {
            self.fetchUsers()
        }
    }
    
    func fetchUsers() {
        FoundrySocketIOManager.sharedInstance.getUsers() { users in
            self.foundryUsers = users
        }
    }
}
