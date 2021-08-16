//
//  UserAuthenticationViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class UserAuthenticationViewModel: ObservableObject {
    @Published var userAuthSuccessful = false
    @Published var sentLoginRequest = false

    var userAuthListener: SetupUserAuthenticationListener?

    init() {
        do {
            try userAuthListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func verifyUserAuth(user: UserModel, password: String) {
        sentLoginRequest = true
        if let listener = userAuthListener {
            listener.userLogin(user: user, password: password) { loginResult in
                self.userAuthSuccessful = loginResult
                self.sentLoginRequest = false
            }
        }
    }

    func completeSetup(user: UserModel, actor: ActorModel) {
        FoundrySocketIOManager.sharedInstance.finishSetup(user: user, actor: actor)
    }
}
