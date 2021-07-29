//
//  FoundryConnectionViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/2/21.
//

import Foundation

class FoundryConnectViewModel: ObservableObject {
    @Published var id = "";
    
    func isIdValid() -> Bool {
        return UUID(uuidString: id) != nil
    }
}
