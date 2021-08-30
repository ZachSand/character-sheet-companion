//
//  InventoryModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import Foundation

struct ActorInventoryModel: Codable, BaseModel {
    var currentCapacity: Double
    var carryingCapacity: Int
    var weapons: [ActorInventoryItemModel]
    var equipment: [ActorInventoryItemModel]
    var consumables: [ActorInventoryItemModel]
    var tools: [ActorInventoryItemModel]
    var containers: [ActorInventoryItemModel]
    var loot: [ActorInventoryItemModel]

    static func getRequestEvent() -> String {
        SocketEvents.IOS.ACTOR.REQUEST_ACTOR_INVENTORY
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_INVENTORY
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_INVENTORY = "ios:requestActorInventory"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_INVENTORY = "server:sendActorInventory"
}

#if DEBUG
    extension ActorInventoryModel {
        static let mockedData = ActorInventoryModel(
            currentCapacity: 125.0,
            carryingCapacity: 200,
            weapons: ActorInventoryItemModel.mockedDataWeapons,
            equipment: ActorInventoryItemModel.mockedDataEquipment,
            consumables: ActorInventoryItemModel.mockedDataConsumables,
            tools: ActorInventoryItemModel.mockedDataTools,
            containers: ActorInventoryItemModel.mockedDataContainers,
            loot: ActorInventoryItemModel.mockedDataLoot
        )
    }
#endif
