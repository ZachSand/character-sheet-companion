//
//  CharacterHealthSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/20/21.
//

import Foundation

class CharacterHealthSheetViewModel {
    private var attributesListener: ActorAttributesListener?

    init() {
        do {
            try attributesListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func applyDamage(healthChange: Int) {
        if let listener = attributesListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            listener.requestActorHealthChange(actorId: actor.id, healthChange: healthChange)
        }
    }
}
