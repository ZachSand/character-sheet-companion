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

    let manager: SocketManager
    let socket: SocketIOClient

    let listeners: [SocketListener]

    override init() {
        manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(false), .compress])
        socket = manager.defaultSocket

        listeners = [
            // Setup Listeners
            ConnectionListener(socket: socket),
            UsersListener(socket: socket),
            ActorListener(socket: socket),
            ActorDataListener(socket: socket),
            WorldDataListener(socket: socket),

            // Roll Listeners
            AbilityListener(socket: socket),
            SkillListener(socket: socket),
            ItemAttackListener(socket: socket),
            ItemDamageListener(socket: socket),
            ItemConsumeListener(socket: socket),
            ItemToolListener(socket: socket),
            InitiativeListener(socket: socket),

            // Display Listeners
            ItemDisplayListener(socket: socket),
            ChatMessageListener(socket: socket),
            SpellDialogListener(socket: socket),
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
