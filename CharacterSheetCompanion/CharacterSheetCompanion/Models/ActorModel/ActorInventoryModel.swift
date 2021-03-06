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
        REQUEST_EVENTS.ACTOR.INVENTORY
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ACTOR.INVENTORY
    }
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
