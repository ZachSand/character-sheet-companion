//
//  SetupListenerWrapper.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation
import SocketIO

class SetupListenerWrapper: ListenerWrapper {
    var socketListeners: [SocketListener]
    var socket: SocketIOClient

    let setupWorldListener: GenericModelSocketListener<WorldDataModel>
    let setupUsersListener: GenericModelSocketListener<SetupUserArrayModel>
    let setupUserAuthListener: GenericModelSocketListener<SetupUserAuthModel>

    let setupConnectionListener: SetupConnectionListener

    init(socket: SocketIOClient) {
        self.socket = socket

        setupWorldListener = GenericModelSocketListener<WorldDataModel>(socket: socket)
        setupUsersListener = GenericModelSocketListener<SetupUserArrayModel>(socket: socket)
        setupUserAuthListener = GenericModelSocketListener<SetupUserAuthModel>(socket: socket)

        setupConnectionListener = SetupConnectionListener(socket: socket)

        socketListeners = [
            setupWorldListener,
            setupUsersListener,
            setupUserAuthListener,
            setupConnectionListener,
        ]
    }
}
