//
//  FoundryCompanionServerSocketManager.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/2/21.
//

import Foundation
import SocketIO

class SocketManagerWrapper: NSObject {
    static let sharedInstance = SocketManagerWrapper()

    private let manager: SocketManager
    private let socket: SocketIOClient

    let actorListenerWrapper: ActorListenerWrapper
    let setupListenerWrapper: SetupListenerWrapper
    let rollListenerWrapper: RollListenerWrapper
    let displayListenerWrapper: DisplayListenerWrapper
    let actorChangeListener: ActorChangeListener

    var user: SetupUserModel?
    var actor: SetupActorModel?
    var socketRoomId: String?

    override private init() {
        manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(false), .compress])
        socket = manager.defaultSocket

        actorListenerWrapper = ActorListenerWrapper(socket: socket)
        setupListenerWrapper = SetupListenerWrapper(socket: socket)
        rollListenerWrapper = RollListenerWrapper(socket: socket)
        displayListenerWrapper = DisplayListenerWrapper(socket: socket)
        actorChangeListener = ActorChangeListener(socket: socket)

        Array([
            actorListenerWrapper.socketListeners,
            setupListenerWrapper.socketListeners,
            rollListenerWrapper.socketListeners,
            displayListenerWrapper.socketListeners,
        ]
        .joined()).forEach { socketListener in
            socketListener.addSocketHandlers()
        }

        super.init()
        socket.connect()
    }

    func emitCompletedSetup(user: SetupUserModel, actor: SetupActorModel) {
        self.user = user
        self.actor = actor
        socket.emit(REQUEST_EVENTS.SETUP.COMPLETE, actor.id, user.id)
    }
}

enum FoundryJSONError: Error {
    case errorMessage(String)
}

enum SocketListenerError: Error {
    case errorMessage(String)
}
