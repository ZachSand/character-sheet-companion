//
//  DeathSaveViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/20/21.
//

import Foundation

class DeathSaveViewModel {
    var deathSaveRollListener: RollDeathSaveListener?

    init() {
        do {
            try deathSaveRollListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func rollDeathSave(advantage: Bool, disadvantage: Bool) {
        if let listener = deathSaveRollListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let rollModel = DeathSaveRollModel(actorId: actor.id, advantage: advantage, disadvantage: disadvantage, result: 0)
            listener.rollDeathSave(deathSaveRoll: rollModel) { rollResult in
                print(rollResult)
            }
        }
    }
}
