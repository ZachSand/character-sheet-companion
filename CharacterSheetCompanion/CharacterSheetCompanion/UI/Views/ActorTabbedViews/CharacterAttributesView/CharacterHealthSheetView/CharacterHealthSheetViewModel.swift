//
//  CharacterHealthSheetViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/20/21.
//

import Foundation

class CharacterHealthSheetViewModel {
    private var actorChangeListener = SocketManagerWrapper.sharedInstance.actorChangeListener

    func applyDamage(healthChange: Int) {
        actorChangeListener.requestActorHealthChange(healthChange: healthChange)
    }
}
