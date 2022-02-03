//
//  UsersPickerViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/18/21.
//

import Combine
import Foundation

class UserPickerViewModel: ObservableObject {
    @Published var users: [SetupUserModel]?
    private var subscription = Set<AnyCancellable>()

    private var usersListener = SocketManagerWrapper.sharedInstance.setupListenerWrapper.setupUsersListener

    init() {
        usersListener.modelPublisher.receive(on: DispatchQueue.main)
            .sink(receiveValue: { model in
                self.users = model?.users
            })
            .store(in: &subscription)
        usersListener.request()
    }
}
