//
//  ActorListener.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/30/21.
//

import Foundation

protocol ActorListener {
    func requestInitialActorData()
    func isReady() -> Bool
}
