//
//  FoundryConnectionViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/2/21.
//

import Foundation

class ConnectViewModel: ObservableObject {
    @Published var characterCompanionId = ""
    @Published var connectSuccess = false

    private var connectionListener = SocketManagerWrapper.sharedInstance.setupListenerWrapper.setupConnectionListener

    func isIdValid() -> Bool {
        UUID(uuidString: characterCompanionId) != nil
    }

    func connect() {
        connectionListener.joinSocketRoom(socketRoomId: characterCompanionId) { connectionResult in
            self.connectSuccess = connectionResult
        }
    }
}
