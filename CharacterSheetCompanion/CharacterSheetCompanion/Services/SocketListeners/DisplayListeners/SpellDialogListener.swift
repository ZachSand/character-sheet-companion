//
//  SpellDialogListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/5/21.
//

import Foundation
import SocketIO

class SpellDialogListener: SocketListener {
    let socket: SocketIOClient

    var spellDialogCallback: (([SpellDialogModel]?) -> Void)?

    init(socket: SocketIOClient) {
        self.socket = socket
    }

    func addSocketHandlers() {
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_SPELL_DIALOG) { data, _ in
            do {
                try self.spellDialogCallback?(SocketListenerUtility.parseSocketEventDataArray(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }

    func getSpellDialog(actorId: String, spellId: String, completionHandler: @escaping ([SpellDialogModel]?) -> Void) {
        socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_SPELL_DIALOG, actorId, spellId)
        spellDialogCallback = completionHandler
    }
}

extension SocketEvents.IOS {
    static let REQUEST_FOUNDRY_SPELL_DIALOG = "ios:requestFoundrySpellDialog"
}

extension SocketEvents.SERVER {
    static let SEND_FOUNDRY_SPELL_DIALOG = "server:sendFoundrySpellDialog"
}
