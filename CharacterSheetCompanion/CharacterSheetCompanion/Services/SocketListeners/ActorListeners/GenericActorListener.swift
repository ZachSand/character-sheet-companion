//
//  GenericActorListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Combine
import Foundation
import SocketIO

class GenericActorListener<ModelType: BaseModel>: GenericModelSocketListener<ModelType>, ActorListener {
    private var receivedFirstMessage = false

    override func addSocketHandlers() {
        socket.on(ModelType.getReceiveEvent()) { data, _ in
            do {
                self.modelSubject.send(try SocketListenerUtility.parseSocketEventData(data))
                self.receivedFirstMessage = true
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func requestInitialActorData() {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            socket.emit(ModelType.getRequestEvent(), actor.id)
        }
    }

    func isReady() -> Bool {
        receivedFirstMessage
    }
}
