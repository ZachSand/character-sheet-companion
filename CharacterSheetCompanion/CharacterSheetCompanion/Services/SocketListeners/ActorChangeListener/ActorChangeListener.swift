//
//  ActorChangeListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 9/9/21.
//

import Foundation
import SocketIO

class ActorChangeListener: SocketListener {
    let socket: SocketIOClient

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        // No Listener for item display
    }

    func requestActorHealthChange(healthChange: Int) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            socket.emit(REQUEST_EVENTS.ACTOR_CHANGE.HEALTH, actor.id, healthChange)
        }
    }

    func requestActorShortRest() {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            socket.emit(REQUEST_EVENTS.ACTOR_CHANGE.SHORT_REST, actor.id)
        }
    }

    func requestActorLongRest() {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            socket.emit(REQUEST_EVENTS.ACTOR_CHANGE.LONG_REST, actor.id)
        }
    }
}
