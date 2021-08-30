//
//  DeathSaveViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/20/21.
//

import Foundation

class DeathSaveViewModel {
    var deathSaveRollListener = SocketManagerWrapper.sharedInstance.rollListenerWrapper.deathSaveRollListener

    func rollDeathSave(advantage: Bool, disadvantage: Bool) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            deathSaveRollListener.request(model: DeathSaveRollModel(actorId: actor.id, advantage: advantage, disadvantage: disadvantage, result: 0))
        }
    }
}
