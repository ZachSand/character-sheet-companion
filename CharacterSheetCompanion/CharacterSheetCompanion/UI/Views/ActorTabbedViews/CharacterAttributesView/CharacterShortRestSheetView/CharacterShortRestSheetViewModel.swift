//
//  CharacterShortRestSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/23/21.
//

import Foundation

class CharacterShortRestSheetViewModel {
    private var hitDieListener: RollHitDieListener?
    private var attributeListener: ActorAttributesListener?

    init() {
        do {
            try hitDieListener = FoundrySocketIOManager.sharedInstance.getListener()
            try attributeListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func rollHitDie(actorClass: ActorClassModel) {
        if let listener = hitDieListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let hitDieRoll = HitDieRollModel(actorId: actor.id, hitDie: actorClass.hitDice, result: 0)
            listener.rollHitDie(hitDieRoll: hitDieRoll) { rollResult in
                print(rollResult)
            }
        }
    }

    func longRest() {
        if let listener = attributeListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            listener.requestActorLongRest(actorId: actor.id)
        }
    }

    func shortRest() {
        if let listener = attributeListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            listener.requestActorShortRest(actorId: actor.id)
        }
    }
}
