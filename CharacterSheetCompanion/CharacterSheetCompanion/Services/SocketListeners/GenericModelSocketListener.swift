//
//  GenericSocketListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/30/21.
//

import Combine
import Foundation
import SocketIO

class GenericModelSocketListener<ModelType: BaseModel>: SocketListener {
    let socket: SocketIOClient
    let modelPublisher: AnyPublisher<ModelType?, Never>
    let modelSubject = CurrentValueSubject<ModelType?, Never>(nil)
    let jsonEncoder = JSONEncoder()

    init(socket: SocketIOClient) {
        self.socket = socket
        modelPublisher = modelSubject.eraseToAnyPublisher()
    }

    func addSocketHandlers() {
        socket.on(ModelType.getReceiveEvent()) { data, _ in
            do {
                self.modelSubject.send(try SocketListenerUtility.parseSocketEventData(data))
            } catch let FoundryJSONError.errorMessage(errorMessage) {
                preconditionFailure("Failed to decode JSON with \(errorMessage)")
            } catch {
                preconditionFailure("Failed to decode JSON with \(error)")
            }
        }
    }

    func request() {
        socket.emit(ModelType.getRequestEvent())
    }

    func request(model: ModelType) {
        do {
            let jsonData = try jsonEncoder.encode(model)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(ModelType.getRequestEvent(), json)
            }
        } catch {
            preconditionFailure("Failed to encode JSON for \(model)")
        }
    }
}
