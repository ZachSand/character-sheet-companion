//
//  FoundryUserActorFetcher.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/13/21.
//

import Foundation

class UserActorListViewModel: ObservableObject {
    @Published var foundryUserActors: [FoundryUserActor]?
    var user: FoundryUser
    
    init(user: FoundryUser) {
        self.user = user
        DispatchQueue.main.async {
            self.fetchUserActors(userId: self.user.id)
        }
    }
    
    func fetchUserActors(userId: String) {
        FoundrySocketIOManager.sharedInstance.getUserActors(userId: userId) { userActors in
            self.foundryUserActors = userActors
        }
    }
}
