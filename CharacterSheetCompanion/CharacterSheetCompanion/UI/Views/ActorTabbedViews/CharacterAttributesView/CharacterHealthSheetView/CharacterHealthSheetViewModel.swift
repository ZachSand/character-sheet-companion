//
//  CharacterHealthSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/20/21.
//

import Foundation

class CharacterHealthSheetViewModel {
    private var attributesListener = SocketManagerWrapper.sharedInstance.actorListenerWrapper.actorAttributesListener

    func applyDamage(healthChange: Int) {
        attributesListener.requestActorHealthChange(healthChange: healthChange)
    }
}
