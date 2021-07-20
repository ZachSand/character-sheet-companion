//
//  FoundryMockedData.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/6/21.
//

import Foundation

extension FoundryUser {
    static let mockedData: [FoundryUser] = [
        FoundryUser(userId: "userId-abc-123", userName: "John Doe", isActive: true),
        FoundryUser(userId: "userId-def-456", userName: "Jane Doe", isActive: true),
        FoundryUser(userId: "userId-hij-789", userName: "Gamemaster", isActive: true),
    ]
}

extension FoundryUserActor {
    static let mockedData: [FoundryUserActor] = [
        FoundryUserActor(actorId: "actorId-abc-123", name: "Caleb Widowgast"),
        FoundryUserActor(actorId: "actorId-def-345", name: "Beauregard Lionett"),
        FoundryUserActor(actorId: "actorId-hij-678", name: "Nott the Brave")
    ]
}
