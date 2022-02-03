//
//  ActorListenerWrapper.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/11/21.
//

import Foundation
import SocketIO

class ActorListenerWrapper: ListenerWrapper {
    var socketListeners: [SocketListener]
    var socket: SocketIOClient

    private var isActorDataReady = false
    private var actorDataReadyCallback: ((Bool) -> Void)?
    private var dataLoadCount = 0
    private var dataLoadTimer: Timer?

    let actorAbilityListener: GenericActorListener<ActorAbilityModelArray>
    let actorDetailsListener: GenericActorListener<ActorDetailsModel>
    let actorInventoryListener: GenericActorListener<ActorInventoryModel>
    let actorSkillsListener: GenericActorListener<ActorSkillArrayModel>
    let actorSpellSlotListener: GenericActorListener<ActorSpellSlotArrayModel>
    let actorSpellListener: GenericActorListener<ActorSpellArrayModel>
    let actorCurrencyListener: GenericActorListener<ActorCurrencyModel>
    let actorBaseDataListener: GenericActorListener<ActorBaseDataModel>
    let actorClassesListener: GenericActorListener<ActorClassArrayModel>
    let actorTraitsListener: GenericActorListener<ActorTraitsModel>
    let actorAttributesListener: GenericActorListener<ActorAttributesModel>

    init(socket: SocketIOClient) {
        self.socket = socket
        actorAbilityListener = GenericActorListener<ActorAbilityModelArray>(socket: socket)
        actorDetailsListener = GenericActorListener<ActorDetailsModel>(socket: socket)
        actorInventoryListener = GenericActorListener<ActorInventoryModel>(socket: socket)
        actorSkillsListener = GenericActorListener<ActorSkillArrayModel>(socket: socket)
        actorSpellSlotListener = GenericActorListener<ActorSpellSlotArrayModel>(socket: socket)
        actorSpellListener = GenericActorListener<ActorSpellArrayModel>(socket: socket)
        actorCurrencyListener = GenericActorListener<ActorCurrencyModel>(socket: socket)
        actorBaseDataListener = GenericActorListener<ActorBaseDataModel>(socket: socket)
        actorClassesListener = GenericActorListener<ActorClassArrayModel>(socket: socket)
        actorTraitsListener = GenericActorListener<ActorTraitsModel>(socket: socket)
        actorAttributesListener = GenericActorListener<ActorAttributesModel>(socket: socket)

        socketListeners = [
            actorAbilityListener,
            actorDetailsListener,
            actorInventoryListener,
            actorSkillsListener,
            actorSpellSlotListener,
            actorSpellListener,
            actorCurrencyListener,
            actorBaseDataListener,
            actorClassesListener,
            actorTraitsListener,
            actorAttributesListener,
        ]
    }

    func requestActorData() {
        socketListeners.forEach { listener in
            if let actorListener = listener as? ActorListener {
                actorListener.requestInitialActorData()
            } else {
                preconditionFailure("Actor listener wrapper has listener that doesn't conform to ActorListener in requestActorData")
            }
        }
        dataLoadTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(isActorDataIsReady), userInfo: nil, repeats: true)
    }

    func isActorDataReady(completionHandler: @escaping (Bool) -> Void) {
        actorDataReadyCallback = completionHandler
    }

    @objc func isActorDataIsReady(dataLoadTimer: Timer) {
        isActorDataReady = socketListeners.allSatisfy { listener in
            if let actorListener = listener as? ActorListener {
                return actorListener.isReady()
            } else {
                preconditionFailure("Actor listener wrapper has listener that doesn't conform to ActorListener in isActorDataReady")
            }
        }
        dataLoadCount += 1

        if dataLoadCount == 10 || isActorDataReady {
            dataLoadTimer.invalidate()
            actorDataReadyCallback?(isActorDataReady)
        }
    }
}
