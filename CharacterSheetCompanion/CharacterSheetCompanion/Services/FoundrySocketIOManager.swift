//
//  FoundryCompanionServerSocketManager.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/2/21.
//

import Foundation
import SocketIO

class FoundrySocketIOManager: NSObject {
    static let sharedInstance = FoundrySocketIOManager()

    private let manager: SocketManager
    private let socket: SocketIOClient
    private let listeners: [SocketListener]

    var user: UserModel?
    var actor: ActorModel?

    override private init() {
        manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(false), .compress])
        socket = manager.defaultSocket

        listeners = [
            // Setup Listeners
            SetupConnectionListener(socket: socket),
            SetupUsersListener(socket: socket),
            SetupActorsListener(socket: socket),
            SetupWorldDataListener(socket: socket),

            // Actor Listeners
            ActorAbilityListener(socket: socket),
            ActorBiographyListener(socket: socket),
            ActorInventoryListener(socket: socket),
            ActorOverviewListener(socket: socket),
            ActorSkillListener(socket: socket),
            ActorSpellSlotListener(socket: socket),

            // Roll Listeners
            RollAbilityListener(socket: socket),
            RollSkillListener(socket: socket),
            RollItemAttackListener(socket: socket),
            RollItemDamageListener(socket: socket),
            RollItemConsumeListener(socket: socket),
            RollToolListener(socket: socket),
            RollInitiativeListener(socket: socket),

            // Display Listeners
            DisplayItemListener(socket: socket),
            DisplayChatMessageListener(socket: socket),
        ]

        super.init()
        addSocketHandlers()
    }

    func getListener<Listener: SocketListener>() throws -> Listener {
        if let concreteListener = listeners.filter({ $0 is Listener }).first {
            if let downcastListener = concreteListener as? Listener {
                return downcastListener
            }
        }
        throw SocketListenerError.errorMessage("Could not find Socket Listener")
    }

    private func addSocketHandlers() {
        listeners.forEach { listener in
            listener.addSocketHandlers()
        }
    }
}

enum FoundryJSONError: Error {
    case errorMessage(String)
}

enum SocketListenerError: Error {
    case errorMessage(String)
}
