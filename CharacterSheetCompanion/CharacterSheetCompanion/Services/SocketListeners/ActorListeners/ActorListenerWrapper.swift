//
//  ActorListenerWrapper.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Foundation

class ActorListenerWrapper: ObservableObject {
    private var isActorDataReady = false
    private var actorDataReadyCallback: ((Bool) -> Void)?
    private var actorListeners: [ActorListener]
    private var dataLoadCount = 0
    private var dataLoadTimer: Timer?

    init() {
        var abilityListener: ActorAbilityListener?
        var detailsListener: ActorDetailsListener?
        var inventoryListener: ActorInventoryListener?
        var overviewListener: ActorAttributesListener?
        var skillListener: ActorSkillListener?
        var spellSlotsListener: ActorSpellSlotListener?
        var currencyListener: ActorCurrencyListener?
        var spellsListener: ActorSpellListener?
        var baseDataListener: ActorBaseDataListener?
        var classesListener: ActorClassesListener?
        var traitsListener: ActorTraitsListener?

        do {
            try abilityListener = FoundrySocketIOManager.sharedInstance.getListener()
            try detailsListener = FoundrySocketIOManager.sharedInstance.getListener()
            try inventoryListener = FoundrySocketIOManager.sharedInstance.getListener()
            try overviewListener = FoundrySocketIOManager.sharedInstance.getListener()
            try skillListener = FoundrySocketIOManager.sharedInstance.getListener()
            try spellSlotsListener = FoundrySocketIOManager.sharedInstance.getListener()
            try currencyListener = FoundrySocketIOManager.sharedInstance.getListener()
            try spellsListener = FoundrySocketIOManager.sharedInstance.getListener()
            try baseDataListener = FoundrySocketIOManager.sharedInstance.getListener()
            try classesListener = FoundrySocketIOManager.sharedInstance.getListener()
            try traitsListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}

        actorListeners = [
            abilityListener!,
            detailsListener!,
            inventoryListener!,
            overviewListener!,
            skillListener!,
            spellSlotsListener!,
            currencyListener!,
            spellsListener!,
            baseDataListener!,
            classesListener!,
            traitsListener!,
        ]
    }

    func requestActorData() {
        if let actor = FoundrySocketIOManager.sharedInstance.actor {
            actorListeners.forEach { actorListener in
                actorListener.requestInitialActorData(actorId: actor.id)
            }
            dataLoadTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(isActorDataIsReady), userInfo: nil, repeats: true)
        }
    }

    func isActorDataReady(completionHandler: @escaping (Bool) -> Void) {
        actorDataReadyCallback = completionHandler
    }

    @objc func isActorDataIsReady(dataLoadTimer: Timer) {
        isActorDataReady = actorListeners.allSatisfy { actorListener in
            actorListener.isReady()
        }
        dataLoadCount += 1

        if dataLoadCount == 10 || isActorDataReady {
            dataLoadTimer.invalidate()
            actorDataReadyCallback?(isActorDataReady)
        }
    }
}
