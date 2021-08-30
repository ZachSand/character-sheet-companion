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
    @Published var setupUserAuthModel = SetupUserAuthModel(id: "", password: "", passwordMatches: false)

    private var userAuthListener = SocketManagerWrapper.sharedInstance.setupListenerWrapper.setupUserAuthListener
    private var subscription = Set<AnyCancellable>()

    init() {}

    func verifyUserAuth(user _: SetupUserModel, actor _: SetupActorModel, password _: String) {
        authState = AuthState.AUTHENTICATING
        userAuthListener.modelPublisher
            .sink(receiveValue: { model in
                if let userAuthModel = model {
                    self.setupUserAuthModel = userAuthModel
                    if self.setupUserAuthModel.passwordMatches {
                        self.authState = AuthState.AUTHENTICATED
                    } else {
                        self.authState = AuthState.FAILED_AUTHENTICATION
                    }
                }
            })
            .store(in: &subscription)
        userAuthListener.request()
    }

    func completeSetup(user: SetupUserModel, actor: SetupActorModel) {
        SocketManagerWrapper.sharedInstance.emitCompletedSetup(user: user, actor: actor)
    }
}

enum AuthState {
    case NOT_AUTHENTICATING, AUTHENTICATING, FAILED_AUTHENTICATION, AUTHENTICATED
}
