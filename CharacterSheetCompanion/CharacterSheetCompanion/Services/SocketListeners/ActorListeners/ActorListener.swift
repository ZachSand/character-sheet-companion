//
//  ActorListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Foundation

protocol ActorListener {
    func requestInitialActorData(actorId: String)
    func isReady() -> Bool
}
