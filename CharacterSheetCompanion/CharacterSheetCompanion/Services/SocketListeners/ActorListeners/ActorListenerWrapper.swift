//
//  ActorListenerWrapper.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Foundation

class ActorListenerWrapper: ObservableObject {
    @Published var isActorDataReady: Bool
    private var actorListeners: [ActorListener]
    private var dataLoadCount: Int
    private var dataLoadTimer: Timer?

    init() {
        isActorDataReady = false
        dataLoadCount = 0

        var abilityListener: ActorAbilityListener?
        var biographyListener: ActorBiographyListener?
        var inventoryListener: ActorInventoryListener?
        var overviewListener: ActorOverviewListener?
        var skillListener: ActorSkillListener?
        var spellSlotsListener: ActorSpellSlotListener?
        var currencyListener: ActorCurrencyListener?
        var spellsListener: ActorSpellListener?

        do {
            try abilityListener = FoundrySocketIOManager.sharedInstance.getListener()
            try biographyListener = FoundrySocketIOManager.sharedInstance.getListener()
            try inventoryListener = FoundrySocketIOManager.sharedInstance.getListener()
            try overviewListener = FoundrySocketIOManager.sharedInstance.getListener()
            try skillListener = FoundrySocketIOManager.sharedInstance.getListener()
            try spellSlotsListener = FoundrySocketIOManager.sharedInstance.getListener()
            try currencyListener = FoundrySocketIOManager.sharedInstance.getListener()
            try spellsListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}

        actorListeners = [
            abilityListener!,
            biographyListener!,
            inventoryListener!,
            overviewListener!,
            skillListener!,
            spellSlotsListener!,
            currencyListener!,
            spellsListener!,
        ]

        requestActorData()
        dataLoadTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(isActorDataIsReady), userInfo: nil, repeats: true)
    }

    private func requestActorData() {
        if let actor = FoundrySocketIOManager.sharedInstance.actor {
            actorListeners.forEach { actorListener in
                actorListener.requestInitialActorData(actorId: actor.id)
            }
        }
    }

    @objc func isActorDataIsReady(dataLoadTimer: Timer) {
        isActorDataReady = actorListeners.allSatisfy { actorListener in
            actorListener.isReady()
        }
        dataLoadCount += 1

        if dataLoadCount == 10 || isActorDataReady {
            dataLoadTimer.invalidate()
        }
    }
}
