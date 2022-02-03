//
//  RollListenerWrapper.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation
import SocketIO

class RollListenerWrapper: ListenerWrapper {
    var socketListeners: [SocketListener]
    var socket: SocketIOClient

    let initiativeRollListener: GenericModelSocketListener<InitiativeRollModel>
    let itemToolRollListener: GenericModelSocketListener<ItemToolRollModel>
    let itemConsumeRollListener: GenericModelSocketListener<ItemConsumeRollModel>
    let itemDamageRollListener: GenericModelSocketListener<ItemDamageRollModel>
    let abilityRollListener: GenericModelSocketListener<AbilityRollModel>
    let skillRollListener: GenericModelSocketListener<SkillRollModel>
    let itemAttackRollListener: GenericModelSocketListener<ItemAttackRollModel>
    let deathSaveRollListener: GenericModelSocketListener<DeathSaveRollModel>
    let hitDieRollListener: GenericModelSocketListener<HitDieRollModel>

    init(socket: SocketIOClient) {
        self.socket = socket

        initiativeRollListener = GenericModelSocketListener<InitiativeRollModel>(socket: socket)
        itemToolRollListener = GenericModelSocketListener<ItemToolRollModel>(socket: socket)
        itemConsumeRollListener = GenericModelSocketListener<ItemConsumeRollModel>(socket: socket)
        itemDamageRollListener = GenericModelSocketListener<ItemDamageRollModel>(socket: socket)
        abilityRollListener = GenericModelSocketListener<AbilityRollModel>(socket: socket)
        skillRollListener = GenericModelSocketListener<SkillRollModel>(socket: socket)
        itemAttackRollListener = GenericModelSocketListener<ItemAttackRollModel>(socket: socket)
        deathSaveRollListener = GenericModelSocketListener<DeathSaveRollModel>(socket: socket)
        hitDieRollListener = GenericModelSocketListener<HitDieRollModel>(socket: socket)

        socketListeners = [
            initiativeRollListener,
            itemToolRollListener,
            itemConsumeRollListener,
            itemDamageRollListener,
            abilityRollListener,
            skillRollListener,
            itemAttackRollListener,
            deathSaveRollListener,
            hitDieRollListener,
        ]
    }
}
