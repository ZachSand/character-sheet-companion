//
//  ActorAbilityListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Foundation
import SocketIO

class ActorAbilityListener: SocketListener {
    let socket: SocketIOClient

    var actorAbilitiesCallback: (([ActorAbilityModel]?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ROLL.SEND.SEND_INITIATIVE_ROLL) { data, _ in
            do {
                try self.actorAbilitiesCallback?(SocketListenerUtility.parseSocketEventDataArray(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getActorAbilities(actorId: String, completionHandler: @escaping ([ActorAbilityModel]?) -> Void) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_ABILITIES, actorId)
        actorAbilitiesCallback = completionHandler
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_ABILITIES = "ios:requestActorAbilities"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_ABILITIES = "server:sendActorAbilities"
}
