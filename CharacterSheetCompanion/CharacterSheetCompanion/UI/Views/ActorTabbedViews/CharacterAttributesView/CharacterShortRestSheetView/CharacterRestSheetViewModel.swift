//
//  CharacterShortRestSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/23/21.
//

import Foundation

class CharacterRestSheetViewModel {
    private var hitDieListener = SocketManagerWrapper.sharedInstance.rollListenerWrapper.hitDieRollListener
    private var actorChangeListener = SocketManagerWrapper.sharedInstance.actorChangeListener

    func rollHitDie(actorClass: ActorClassModel) {
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            hitDieListener.request(model: HitDieRollModel(actorId: actor.id, hitDie: actorClass.hitDice, result: 0))
        }
    }

    func longRest() {
        actorChangeListener.requestActorLongRest()
    }

    func shortRest() {
        actorChangeListener.requestActorShortRest()
    }
}
