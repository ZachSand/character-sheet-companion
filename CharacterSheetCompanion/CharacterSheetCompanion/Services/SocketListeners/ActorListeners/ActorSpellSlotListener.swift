//
//  ActorSpellSlotListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Foundation
import SocketIO

class ActorSpellSlotListener: SocketListener {
    let socket: SocketIOClient

    var actorSpellSlotsCallback: (([ActorSpellSlotModel]?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_SPELL_SLOTS) { data, _ in
            do {
                try self.actorSpellSlotsCallback?(SocketListenerUtility.parseSocketEventDataArray(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getActorSkills(actorId: String, completionHandler: @escaping ([ActorSpellSlotModel]?) -> Void) {
        socket.emit(SocketEvents.IOS.ACTOR.REQUEST_ACTOR_SPELL_SLOTS, actorId)
        actorSpellSlotsCallback = completionHandler
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_SPELL_SLOTS = "ios:requestActorSpellSlots"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_SPELL_SLOTS = "server:sendActorSpellSlots"
}
