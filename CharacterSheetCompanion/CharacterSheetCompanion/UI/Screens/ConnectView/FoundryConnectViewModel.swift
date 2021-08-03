//
//  FoundryConnectionViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/2/21.
//

import Foundation

class FoundryConnectViewModel: ObservableObject {
    @Published var id: String
    @Published var connectSuccess: Bool
    var connectionListener: ConnectionListener?
    
    init() {
        id = ""
        connectSuccess = false
        do {
            try connectionListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {
            
        }
    }
    
    func isIdValid() -> Bool {
        return UUID(uuidString: id) != nil
    }
    
    func connect() {
        if let listener = connectionListener {
            listener.roomId = self.id
            //DispatchQueue.main.async {
                listener.socketConnect { connectSuccess in
                    self.connectSuccess = true
                }
            //}
        }
    }
}
