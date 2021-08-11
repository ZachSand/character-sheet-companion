//
//  ActorOverviewListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Foundation
import SocketIO

class ActorOverviewListener: SocketListener {
    let socket: SocketIOClient

    var actorOverviewCallback: ((ActorOverviewModel?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_OVERVIEW) { data, _ in
            do {
                try self.actorOverviewCallback?(SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getActorInventory(actorId: String, completionHandler: @escaping (ActorOverviewModel?) -> Void) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_OVERVIEW, actorId)
        actorOverviewCallback = completionHandler
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_OVERVIEW = "ios:requestActorOverview"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_OVERVIEW = "server:sendActorOverview"
}
