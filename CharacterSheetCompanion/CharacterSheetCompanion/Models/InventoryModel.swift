//
//  InventoryModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import Foundation

struct InventoryModel {
    var carryingCapacity: Int
    var currency: CurrencyModel
    var weapons: [InventoryItemModel]
    var equipment: [InventoryItemModel]
    var consumables: [InventoryItemModel]
    var tools: [InventoryItemModel]
    var containers: [InventoryItemModel]
    var loot: [InventoryItemModel]
}

#if DEBUG
    extension InventoryModel {
        static let mockedData = InventoryModel(
            carryingCapacity: 200,
            currency: CurrencyModel.mockedData,
            weapons: InventoryItemModel.mockedDataWeapons,
            equipment: InventoryItemModel.mockedDataEquipment,
            consumables: InventoryItemModel.mockedDataConsumables,
            tools: InventoryItemModel.mockedDataTools,
            containers: InventoryItemModel.mockedDataContainers,
            loot: InventoryItemModel.mockedDataLoot
        )
    }
#endif
