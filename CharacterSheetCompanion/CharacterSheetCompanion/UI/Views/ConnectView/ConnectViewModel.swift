//
//  FoundryConnectionViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/2/21.
//

import Foundation

class ConnectViewModel: ObservableObject {
    @Published var characterCompanionId: String
    @Published var connectSuccess: Bool
    var connectionListener: SetupConnectionListener?

    init() {
        characterCompanionId = ""
        connectSuccess = false
        do {
            try connectionListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func isIdValid() -> Bool {
        UUID(uuidString: characterCompanionId) != nil
    }

    func connect() {
        if let listener = connectionListener {
            listener.roomId = characterCompanionId
            listener.socketConnect { _ in
                self.connectSuccess = true
            }
        }
    }
}
