//
//  UserAuthenticationViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Combine
import Foundation

class UserAuthenticationViewModel: ObservableObject {
    @Published var authState: AuthState? = AuthState.NOT_AUTHENTICATING

    private var userAuthListener: SetupUserAuthenticationListener?

    init() {
        do {
            try userAuthListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func verifyUserAuth(user: SetupUserModel, actor _: SetupActorModel, password: String) {
        authState = AuthState.AUTHENTICATING
        if let listener = userAuthListener {
            listener.userLogin(user: user, password: password) { loginResult in
                if loginResult {
                    self.authState = AuthState.AUTHENTICATED
                } else {
                    self.authState = AuthState.FAILED_AUTHENTICATION
                }
            }
        }
    }

    func completeSetup(user: SetupUserModel, actor: SetupActorModel) {
        FoundrySocketIOManager.sharedInstance.emitCompletedSetup(user: user, actor: actor)
    }
}

enum AuthState {
    case NOT_AUTHENTICATING, AUTHENTICATING, FAILED_AUTHENTICATION, AUTHENTICATED
}
