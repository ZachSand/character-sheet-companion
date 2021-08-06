//
//  FoundryConnectionViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/2/21.
//

import Foundation

class FoundryConnectViewModel: ObservableObject {
    @Published var characterCompanionId: String
    @Published var connectSuccess: Bool
    var connectionListener: ConnectionListener?

    init() {
        characterCompanionId = ""
        connectSuccess = false
        do {
            try connectionListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func isIdValid() -> Bool {
        return UUID(uuidString: characterCompanionId) != nil
    }

    func connect() {
        if let listener = connectionListener {
            listener.roomId = characterCompanionId
            // DispatchQueue.main.async {
            listener.socketConnect { _ in
                self.connectSuccess = true
            }
            // }
        }
    }
}
